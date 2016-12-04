% main.m
% FlappyCover main game code
% D Evangelista 2016
% ES200 Fall 2016

% initialize world etc
close all
clear
w = World();
k = KeyboardController(w.fig);
f = FlappyCover(w,k);

% main game loop
%w.update_view();
w.themes.main.play();
t = 0;
while(f.alive)
   f.update();
   w.update_view(f.x);
   pause(w.dt);
   
   % check for collisions
end
w.themes.main.pause();
w.themes.death.play();


