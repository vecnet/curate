# This is a simple wrapper for an underlying scanner; Without it, we'll
# always going to be running actual anti-virus
class FullTextExtractor
  attr_reader :object
  def initialize(object_with_pid)
    @object = ActiveFedora::Base.find(object_with_pid.pid, :cast=>true)
  end

  def call
    if object.respond_to?(:extract_content)
      object.extract_content
    else
      return true
    end
  end
end