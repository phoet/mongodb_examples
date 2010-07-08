desc "run the examples"
task :examples do
  FileList.new('examples/**/*').each{|f| load f}
end

task :default=>:examples
