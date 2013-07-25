# This is a simple wrapper for an underlying scanner; Without it, we'll
# always going to be running actual anti-virus
class FullTextExtractor
  attr_reader :object
  def initialize(object_with_pid)
    puts "Object: #{object_with_pid.inspect}"
    @object = object_with_pid
  end

  def call
    if object.respond_to?(:extract_content)
      puts "extract content"
      object.extract_content
    else
      puts "no extract content"
      return true
    end
  end
end