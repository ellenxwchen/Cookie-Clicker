# ECE241-Final-Project

Our team created Money Clicker, which is a scaled-down version of the popular mobile app game Cookie Clicker with a theme of money instead of cookies. 
The game incorporated the PS2 keyboard, VGA, and the FPGA board to play the game. The game starts with the player having 10 dollars. 
Pressing the PS2 spacebar would increment the player’s amount of money by one, which was shown on both the HEX display and the VGA monitor.
The player could also buy various upgrades, one of which would start incrementing the score by a fixed rate every 0.5 seconds, 
the other altering the rate at which each press of the spacebar increments the score. 



We aimed to get the basic game logic first, by using counters, rate dividers, and finite state machines.
We then implemented the PS2 keyboard with the space bar, number keys 1 to 8, and the “C” key to play the game. 
The VGA monitor displayed the score along with the list of upgrades.
