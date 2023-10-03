# CSCI-5611-Project-1

Created by 
# Andrew Minerva
and Graham Smith

Features:
1. Basic Pinball Dynamics: A ball falls down the screen, and accelerates according to gravity.
2. Multiple Balls Interacting: By lighting up all of the circular objects at once, the player can earn multi-ball. More balls are added to the simulation that bounce off of each other.
3. Circular Obstacles: Multiple circles are spread around the board. The player can hit the circles with the ball to light them up.
4. Line-Segment/Polygonal Obstacles: There are rectangles on the board that get in the way of the ball as it moves.
5. Textured Background: The board features a custom thematic image.
6. Reactive Obstacles: The circular obstacles light up when hit. When all circles are lit up, multi-ball is unlocked.
7. Score Display: Points are earned by hitting circular obstacles. The points are displayed at the top of the screen.
8. Progressive Objectives: If the three circles in the tiny santa's hat are lit up, a point multiplier is applied. If all of the circles are lit up, multi-ball is unlocked.
9. Pinball Game Mechanics: Flippers are included to keep the ball in play. When all lives are lost, a game over screen is displayed.

[![Basic Demo](https://img.youtube.com/vi/<VIDEO_ID>/hqdefault.jpg)](https://www.youtube.com/embed/YpJAnOSJA4E)
(Framerate suffered due to screen recording)

[![Multiball and Score Multiplier(Multiple Balls Interacting)](https://img.youtube.com/vi/<VIDEO_ID>/hqdefault.jpg)](https://www.youtube.com/embed/AQSvEMyAUy8)
Score multiplier activates when the three circles in the hat are lit up. Multi-ball activates when all of the circles are lit up.

While creating our pinball game, we had trouble handling the collisions between the flippers and the balls. At first the problem was that the ball would travel directly through the flippers at low framerates. Our initial solution was to correct the ball's position by adding the scaled surface velocity of the flipper at the closest point to the ball. This worked when the flipper was coming up, but on the way down, the ball would be moved under the flipper. To correct this issue, we added a boolean for each flipper that would track if the flipper was moving upward. If the boolean was false, the surface velocity of the flipper would instead be subtracted from the position of the ball.

Art Contest Submission:
![image](https://github.com/smithgraham2002/CSCI-5611-Project-1/assets/103609167/4fcd5c5f-24ca-409e-8285-c58b0575da47)
