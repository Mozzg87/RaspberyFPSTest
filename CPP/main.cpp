#include <SFML/Graphics.hpp>

int main()
{
    // Create the main window
    sf::RenderWindow app(sf::VideoMode(800, 600), "SFML window");

    sf::CircleShape shape(100.f);
    shape.setFillColor(sf::Color::Green);

	// Start the game loop
    while (app.isOpen())
    {
        // Process events
        sf::Event event;
        while (app.pollEvent(event))
        {
            // Close window : exit
            if (event.type == sf::Event::Closed)
                app.close();
        }

        // Clear screen
        app.clear();

        // Draw the sprite
        app.draw(shape);

        // Update the window
        app.display();
    }

    return EXIT_SUCCESS;
}
