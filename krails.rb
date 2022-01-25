# Basic setup stuff.
application "config.app_name = \"#{ARGV[0]}\""

generate(:controller, 'static index about')

# Do all the file copying.
def source_paths
  [File.join(
    File.expand_path(File.dirname(__FILE__)), 'krails_root'
  )] + Array(super)
end

inside 'config' do
  remove_file 'routes.rb'
  copy_file 'routes.rb'
end

inside 'lib' do
  inside 'assets' do
    inside 'stylesheets' do
      copy_file 'sticky-footer-navbar.css'
      copy_file 'typography.css'
    end
  end
end

inside 'app' do
  inside 'assets' do
    inside 'stylesheets' do
      remove_file 'application.css'
      copy_file 'application.css'
    end
  end
  inside 'helpers' do
    remove_file 'application_helper.rb'
    copy_file 'application_helper.rb'
  end
  inside 'views' do
    inside 'layouts' do
      remove_file 'application.html.erb'
      copy_file 'application.html.erb'
    end
    inside 'shared' do
      copy_file '_footer.html.erb'
      copy_file '_head.html.erb'
      copy_file '_nav.html.erb'
    end
    inside 'static' do
      remove_file 'index.html.erb'
      copy_file 'index.html.erb'

      remove_file 'about.html.erb'
      copy_file 'about.html.erb'
    end
  end
end

run 'bundle'

# Set up a repository.
after_bundle do
  git :init
  git add: '-A .'
  git commit: '-m "Initial commit."'
end
