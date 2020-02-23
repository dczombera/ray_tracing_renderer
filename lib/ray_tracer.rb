Dir.glob(File.join(__dir__,'ray_tracer', '**', '*.rb'), &method(:require))

module RayTracer
  class Error < StandardError; end
  # Your code goes here...
end
