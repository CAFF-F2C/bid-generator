web: bin/start-stunnel bin/puma -C config/puma.rb -p ${PORT:-3000}
webpack: bin/webpack-dev-server
activejob: bin/start-stunnel bin/aws_sqs_active_job --queue default
release: bin/rails db:migrate
