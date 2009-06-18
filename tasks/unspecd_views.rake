namespace :spec do
  namespace :unspecd do
    desc 'list all views that have no spec'
    task :views do
      views_path = 'app/views'
      spec_path = 'spec/views'
      puts "Views with no specs:"
      puts "  None" unless check_unspecd(views_path, spec_path)
      puts
    end

    desc 'list all models that have no spec'
    task :models do
      models_path = 'app/models'
      spec_path = 'spec/models'
      puts "Models with no specs:"
      puts "  None" unless check_unspecd(models_path, spec_path)
      puts
    end

    desc 'list all controllers that have no spec'
    task :controllers do
      controllers_path = 'app/controllers'
      spec_path = 'spec/controllers'
      puts "Controllers with no specs:"
      puts "  None" unless check_unspecd(controllers_path, spec_path)
      puts
    end

    desc 'list all libs that have no spec'
    task :libs do
      libs_path = 'lib'
      spec_path = 'spec/lib'
      puts "Libs with no specs:"
      puts "  None" unless check_unspecd(libs_path, spec_path)
      puts
    end
  end

  desc 'list all files that have no spec'
  task :unspecd => ['unspecd:views', 'unspecd:controllers', 'unspecd:models', 'unspecd:libs'] do
  end

  def check_unspecd(file_path, spec_path)
    found_missing = false
    Dir.glob(File.join(file_path, '**', '*.*')).each do |file|
      unless file =~ /.rake$/
        spec = file.gsub(/^#{file_path}(.*?)(?:\.rb)?$/, "#{spec_path}\\1_spec.rb")
        unless File.exist?(spec)
          puts "  #{file}"
          found_missing = true
        end
      end
    end
    found_missing
  end
end
