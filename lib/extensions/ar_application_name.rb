module ArApplicationName
  # We need to set the PGAPPNAME env variable and force the 'pg' gem objects to be
  # recreated with this env variable set. This is done by disconnecting all of the
  # connections in the pool.  We do this because reconnect! on an instance of the
  # AR adapter created prior to our change to PGAPPNAME will have old connection
  # options, which will reset our application_name.
  #
  # Because we fork workers from the server, if we don't disconnect the pool,
  # any call to reconnect! on a connection will cause the worker's connection
  # to have the server's application_name.
  def self.name=(name)
    # TODO: this is postgresql specific
    ENV['PGAPPNAME'] = name
    ActiveRecord::Base.connection_pool.disconnect!
  end
end
