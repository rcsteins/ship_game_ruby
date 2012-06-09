$:.push File.expand_path('../lib', __FILE__)

require 'java'
require 'lwjgl.jar'
require 'slick.jar'
java_import org.newdawn.slick.BasicGame
java_import org.newdawn.slick.GameContainer
java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.SlickException
java_import org.newdawn.slick.AppGameContainer

class Demo < BasicGame
  def render(container, graphics)
    graphics.draw_string('JRuby Demo (ESC to exit)', 8, container.height - 30)
  end

  # Due to how Java decides which method to call based on its
  # method prototype, it's good practice to fill out all necessary
  # methods even with empty definitions.
  def init(container)
  end

  def update(container, delta)
    # Grab input and exit if escape is pressed
    input = container.get_input
    container.exit if input.is_key_down(Input::KEY_ESCAPE)
  end
end

#raise "running test file!"
app = AppGameContainer.new(Demo.new('SlickDemo'))
app.set_display_mode(640, 480, false)
app.start