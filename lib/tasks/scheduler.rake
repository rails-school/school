# Heroku scheduler file

desc "Find BridgeTroll class counts for our users."
task get_bridge_troll_class_count: :environment do
  BridgeTrollRecorder.perform_async
end
