# Basic setup stuff.
application "config.app_name = \"#{ARGV[1]}\""

generate(:controller, 'static index about')
route 'root to: "static#index"'
route 'get "about", to: "static#about", as: :about'

rake 'routes'

# Do all the file copying.
def source_paths
  [File.join(
    File.expand_path(File.dirname(__FILE__)), 'krails_root'
  )] + Array(super)
end

remove_file '.gitignore'
copy_file '.gitignore'

remove_file 'Gemfile'
copy_file 'Gemfile'

inside 'config' do
  inside 'initializers' do
    remove_file 'assets.rb'
    copy_file 'assets.rb'
  end
end

inside 'vendor' do
  inside 'assets' do
    inside 'images' do
      copy_file 'octocat.png'
    end
  end
end

inside 'lib' do
  inside 'assets' do
    inside 'stylesheets' do
      copy_file 'bootstrap-fonts-correct.scss'
      copy_file 'images.css'
      copy_file 'sticky-footer-navbar.css'
      copy_file 'typography.css.scss'
      copy_file 'jumbotron.css'
      copy_file 'dashboard.css'
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
end

inside 'app' do
  inside 'controllers' do
    remove_file 'static_controller.rb'
    copy_file 'static_controller.rb'
  end
end

inside 'app' do
  inside 'helpers' do
    remove_file 'application_helper.rb'
    copy_file 'application_helper.rb'
  end
end

inside 'app' do
  inside 'views' do
    inside 'layouts' do
      remove_file 'application.html.erb'
      copy_file 'application.html.erb'
      copy_file 'jumbotron.html.erb'
      copy_file 'dashboard.html.erb'
    end
    inside 'shared' do
      copy_file '_foot.html.erb'
      copy_file '_head.html.erb'
      copy_file '_lorem.html.erb'
      copy_file '_nav.html.erb'
      copy_file '_scripts.html.erb'
      copy_file '_short_lorem.html.erb'
    end
    inside 'static' do
      remove_file 'index.html.erb'
      copy_file 'index.html.erb'
    end
    inside 'static' do
      remove_file 'about.html.erb'
      copy_file 'about.html.erb'
    end
  end
end

run 'bundle install --path vendor/bundle'
run 'bundle exec figaro install'

# Set up a repository.
after_bundle do
  git :init
  git add: '-A .'
  git commit: '-m "Initial commit."'
end
