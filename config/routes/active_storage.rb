direct :rails_public_blob do |blob|
  if Rails.application.config.cdn_host.present?
    File.join(Rails.application.config.cdn_host, blob.key)
  else
    route =
      # ActiveStorage::VariantWithRecord was introduced in Rails 6.1
      # Remove the second check if you're using an older version
      if blob.is_a?(ActiveStorage::Variant) || blob.is_a?(ActiveStorage::VariantWithRecord)
        :rails_representation
      else
       :rails_blob
      end
    route_for(route, blob)
  end
end
