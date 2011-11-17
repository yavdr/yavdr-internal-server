require 'paperclip/convert_vdr1'

class Logo < ActiveRecord::Base
  has_many :names, :class_name => "LogoName", :dependent => :destroy

  has_attached_file :logo,
                    :path => "public/system/:class/:id/:style.:extension",
                    :url => "/system/:class/:id/:style.:extension",
                    :styles => {
#                      :sd => {
#                        :geometry => "117x88!",
#                        :format => 'png'
#                      },
#                      :hd => {
#                        :geometry => "260x146!",
#                        :format => 'png'
#                      },
:vdr1 => {
  :geometry => "260x146#",
  :format => 'png',
  :processors => [:thumbnail, :convert_vdr1]
}
                    }
#"117x88! -channel RGBA" # (( +clone  -alpha extract -draw 'fill black polygon 0,0 0,15 15,0 fill white circle 15,15 15,0' ( +clone -flip ) -compose Multiply -composite ( +clone -flop ) -compose Multiply -composite) -alpha off -compose CopyOpacity -composite)

  accepts_nested_attributes_for :names, :allow_destroy => true

  def self.archive
    require 'digest/md5'

    tar_file = Tempfile.new(Digest::MD5.hexdigest(Time.now.to_i.to_s))

    Dir.mktmpdir do |tmp|
      FileUtils.chdir(tmp) do
        FileUtils.mkdir_p "vdr-channel-logos/logos"
        FileUtils.cp_r Rails.root.join("resource/debian-logo"), "vdr-channel-logos/debian"
        all.each do |logo|
          file = ""
          logo.names.order("LOWER(name)").each do |name|
            if file.blank?
              file = "#{name.name}.png"
              dirname = File.dirname("vdr-channel-logos/logos/#{file}")
              FileUtils.mkdir_p(dirname)
              FileUtils.cp(Rails.root.join(logo.logo.path(:vdr1)), "vdr-channel-logos/logos/#{file}")
            else
              dirname = File.dirname("vdr-channel-logos/logos/#{name.name}.png")
              FileUtils.mkdir_p(dirname)
              FileUtils.ln_s("#{(dirname.split('/').count-1).times.collect { '../' }.join}#{file}", "vdr-channel-logos/logos/#{name.name}.png")
            end

          end
        end
        Cocaine::CommandLine.new('tar', ['cvzf', tar_file.path, "vdr-channel-logos"].join(' ')).run

      end
    end

    tar_file

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
