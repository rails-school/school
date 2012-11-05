require 'i18n/backend/active_record'
new_backend = I18n::Backend::ActiveRecord.new
I18n.backend = I18n::Backend::Chain.new(new_backend, I18n.backend)

# this can get fancy!
# see https://github.com/svenfuchs/i18n-active_record
