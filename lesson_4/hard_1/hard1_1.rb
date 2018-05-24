=begin
Alyssa has been assigned a task of modifying a class that was initially created
to keep track of secret information. The new requirement calls for adding logging,
when clients of the class attempt to access the secret data.

She needs to modify it so that any access to data must result in a log entry being
generated. That is, any call to the class which will result in data being returned
must first call a logging class.

Hint: Assume that you can modify the initialize method in SecretFile to have an
instance of SecurityLogger be passed in as an additional argument. It may be helpful
to review the lecture on collaborator objects for this practice problem.
=end

class SecretFile
  def initialize(secret_data)
    @data = secret_data
    @access_attempts = SecurityLogger.new # why did we even what this as an argument?
  end

  def data
    @access_attempts.create_log_entry
    @data
  end

  def security_log
    @access_attempts.log
  end
end

class SecurityLogger
  attr_reader :log

  def initialize
    @log = []
  end

  def create_log_entry
    @log << Time.new
  end
end

feces = SecretFile.new("it's just poop")
p feces.data
puts feces.security_log
p feces.data
puts feces.security_log
