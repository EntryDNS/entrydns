desc "Data migrations"
namespace :data do
  task :versions_sync => :environment do
    PaperTrail::Version.where.not(object: nil).find_each do |version|
      if !version.creator_id? && !version.updator_id? && (object = version.reify) &&
          object.respond_to?(:creator_id) && object.respond_to?(:updator_id)
        version.update(creator_id: object.creator_id, updator_id: object.updator_id)
      end
    end
  end
end
