require 'charlock_holmes'

module PrettyDiff
  module Encoding
    extend self

    def enforce(encoding, text)
      result = text
      if (detected = detect(result)) && detected.downcase != encoding.downcase
        result = convert(result, detected, encoding)
      end
      if RUBY_VERSION >= "2.0.0"
        result.force_encoding(encoding)
      else
        result
      end
    end

    def detect(str)
      detected = CharlockHolmes::EncodingDetector.detect(str)
      if detected && detected[:confidence] > 50
        detected[:encoding]
      end
    end

    def convert(str, from, to)
      CharlockHolmes::Converter.convert(str, from, to)
    end

  end
end
