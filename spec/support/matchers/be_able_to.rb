# Allow matching arrays in "ba_able_to"
#
#     user.should be_able_to [:read, :write], post
#
RSpec::Matchers.define :be_able_to do |*args|
  match do |ability|
    arguments = args.dup
    first = arguments.delete_at(0)
    if first.is_a?(Array)
      first.all?{|operation| ability.can?(operation, *arguments)}
    else
      ability.can?(*args)
    end
  end

  failure_message do |ability|
    "expected to be able to #{args.map(&:inspect).join(" ")}"
  end

  failure_message_when_negated do |ability|
    "expected not to be able to #{args.map(&:inspect).join(" ")}"
  end
end
