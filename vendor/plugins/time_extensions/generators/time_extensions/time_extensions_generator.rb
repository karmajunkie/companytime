class TimeExtensionsGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.template 'holiday.rb', 'app/models/holiday.rb'
      m.migration_template 'migration.rb', 'db/migrate'
    end
  end
end
