module InitInterceptor
  def initialize(klass)
    # Intercept this.
    # So, the generic Descriptor base will explicitly construct a new
    # native java instance through super(klass). BUT! super(klass) is
    # in Java SCMDesc(klass), which in fact runs the SCMDesc(RepositoryBrowser)
    # ctor, what we want is the SCMDesc(klass, rbrowser) constructor, which is
    # another one!
    return super(klass, nil) if klass == Java.hudson.scm.SCM.java_class
    super
  end
end

class SCMDescriptor < Java.hudson.scm.SCMDescriptor
  # Needs to be before other Descriptor to intercept
  include InitInterceptor

  include Jenkins::Model::Descriptor

  def method_missing(name, *args)
    warn "#{self.class} missing :: #{name} #{args}"
  end

  def self.method_missing(name, *args)
    warn "#{self} missing :: #{name} #{args}"
  end

  def initialize(*args)
    # raise args.join(', ')
    warn "desc init :: #{args}"
    super(*args)
  end
end

# class UscanBuilder < Jenkins::SCM::SCM
class UscanSCM < Java.hudson.scm.SCM
  include Jenkins::Model::DescribableNative

  describe_as Java.hudson.scm.SCM, :with => SCMDescriptor

  def self.getDisplayName
    'UScan'
  end

  def self.configure(*args)
    warn "configure :: #{args}"
  end

  def initialize(*args)
    warn "init :: #{args}"
    super()
  end

  def checkout(*args)
    warn "checkout :: #{args}"
  end

  def method_missing(name, *args)
    warn "missing :: #{name} #{args}"
  end

  def respond_to?(symbol, *args)
    warn "respond_to? :: #{name} #{args} = #{super}"
    super
  end
end
