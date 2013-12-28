module CapeCod
  module String
    Color::CODES.keys.each do |color|
      define_method color do
        CapeCod.foreground(color, self)
      end

      define_method "on_#{color}".to_s do
        CapeCod.background(color, self)
      end
    end

    EFFECTS.keys.each do |effect|
      define_method effect do
        CapeCod.effect(effect, self)
      end
    end

    def foreground(*color)
      CapeCod.foreground(*color, self)
    end

    def background(*color)
      CapeCod.background(*color, self)
    end

    def effect(effect)
      CapeCod.effect(effect, self)
    end

    alias_method :fg, :foreground
    alias_method :bg, :background
    alias_method :fx, :effect
  end
end
