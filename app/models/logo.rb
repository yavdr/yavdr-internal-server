class Logo < ActiveRecord::Base
  has_many :names, :class_name => "LogoName"
  has_attached_file :logo,
                    :path => "public/system/:class/:id/:style.:extension",
                    :url => "/system/:class/:id/:style.:extension",
                    :styles => {
                      :sd => {
                        :geometry => "117x88",
                        :format => 'png'
                      },
                      :hd => {
                        :geometry => "260x146",
                        :format => 'png'
                      }
                    }

  accepts_nested_attributes_for :names, :allow_destroy => true

  def self.archive
    require 'digest/md5'

    Dir.mktmpdir do |tmp|
      FileUtils.chdir(tmp) do
        FileUtils.mkdir_p "logos"
        all.each do |logo|
          file = ""
          logo.names.order("LOWER(name)").each do |name|
            if file.blank?
              file = "#{name.name}.png"
              FileUtils.cp(Rails.root.join(logo.logo.path), "logos/#{file}")
            else
              FileUtils.ln_s("#{file}", "logos/#{name.name}.png")
            end

          end
        end
        Cocaine::CommandLine.new('tar', ['cvzf', Rails.root.join('logos.tar.gz'), "logos"].join(' ')).run

      end
    end

  end

  def self.importer1(pattern)
    require 'digest/md5'
    Logo.transaction do
      logos = {}

      Dir.glob(pattern).each do |file_name|
        file = File.open(file_name, 'r')
        file_hash = Digest::MD5.hexdigest(file.readlines.join)
        unless logos.include? file_hash
          logos[file_hash] = {
            file_name: file_name,
            file: file,
            names: []
          }
        end

        logos[file_hash][:names] << File.basename(file_name, '.png')
      end

      logos.each do |key, data|
        logo = Logo.create! logo: data[:file]
        data[:names].each do |name|
          logo.names.create! name: name
        end
      end

    end

  end
end
