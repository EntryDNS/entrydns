# https://github.com/activescaffold/active_scaffold/issues/131
class ApplicationController < ActionController::Base
  def self.active_scaffold(*, &_)
    super unless (File.basename($0) == "rake" && ARGV.include?("db:migrate"))
  end
end