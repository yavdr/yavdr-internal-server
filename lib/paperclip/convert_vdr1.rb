module Paperclip
  class ConvertVdr1 < Processor

    class InstanceNotGiven < ArgumentError; end

    def initialize(file, options = {}, attachment = nil)
      super

      geometry             = options[:geometry] # this is not an option
      @file                = file
      @whiny               = options[:whiny].nil? ? true : options[:whiny]
      @format              = options[:format]
      @current_format      = File.extname(@file.path)
      @basename            = File.basename(@file.path, @current_format)

    end

    def make

      src = @file
      dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      dst.binmode

      begin
        parameters = []
        parameters << ":source"
        parameters << ":dest"
        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")
        success = Paperclip.run("#{Rails.root}/script/convert_vdr1.sh", parameters, :source => "#{File.expand_path(src.path)}", :dest => File.expand_path(dst.path))
      rescue Cocaine::ExitStatusError => e
        raise PaperclipError, "There was an error processing the thumbnail for #{@basename}" if @whiny
      rescue Cocaine::CommandNotFoundError => e
        raise Paperclip::CommandNotFoundError.new("Could not run the `convert` command. Please install ImageMagick.")
      end

      dst
      
    end
  end
end
