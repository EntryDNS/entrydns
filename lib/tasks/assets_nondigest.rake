# Needed for webshims
# https://github.com/whatcould/webshims-rails
# https://gist.github.com/eric1234/5692456

require 'fileutils'

desc "Create nondigest versions of all digest assets"
task "assets:precompile" do
  fingerprint = /\-[0-9a-f]{32}\./
  filemap = {}
  Dir["public/assets/**/*"].each do |file|
    next if file !~ fingerprint
    next if File.directory?(file)
    next if file.split(File::Separator).last =~ /^manifest/

    nondigest = file.sub fingerprint, '.'

    if filemap[nondigest]
      if File.mtime(file) > filemap[nondigest][:time]
        filemap[nondigest] = {file: file, time: File.mtime(file)}
      end
    else
      filemap[nondigest] = {file: file, time: File.mtime(file)}
    end
  end
  filemap.each do |nondigest, v|
    FileUtils.cp v[:file], nondigest, verbose: true
  end
end
