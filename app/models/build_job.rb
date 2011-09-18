class BuildJob < Struct.new(:build_id)
  def perform
    build = Build.find(build_id)
    build.process
  end
end

