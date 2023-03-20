module BasicService
  module ClassMethods
    def call(*args, **kwargs, &block)
      new(*args, **kwargs, &block).call
    end

    # Accepts both symbolized and stringified attributes
    def new(*args, **kwargs)
      kwargs.deep_symbolize_keys!
      super(*args, **kwargs)
    end
  end

  def self.prepended(base)
    # See https://dry-rb.org/gems/dry-initializer/3.0/skip-undefined/
    base.extend Dry::Initializer[undefined: false]
    base.extend ClassMethods
  end

  attr_reader :errors

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    @errors = []
  end

  def call
    super
    self
  end

  def success?
    !failure?
  end

  def failure?
    @errors.any?
  end

  private

  def fail_t!(key, **data)
    fail!(I18n.t(key, scope: scope, **data))
  end

  def fail!(messages)
    if messages.is_a?(Array)
      @errors = @errors + messages
    else
      @errors << messages
    end

    self
  end
end
