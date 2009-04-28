module Tags
    RUBY_FILES = FileList['**/*.rb'].exclude("pkg").exclude("vendor")
end

namespace "tags" do
  task :vim => Tags::RUBY_FILES do
    puts "Making Emacs TAGS file"
    sh "ctags  #{Tags::RUBY_FILES}", :verbose => false
  end
  task :emacs => Tags::RUBY_FILES do
      puts "Making Emacs TAGS file"
      sh "ctags  -e #{Tags::RUBY_FILES}", :verbose => false
    end
  end

task :tags => ["tags:emacs", "tags:vim"]
