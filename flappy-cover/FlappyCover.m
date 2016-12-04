classdef FlappyCover < handle

properties
    x = 0; % x position of flappy
    y = 100; % y position of flappy
    vx = 100; % x velocity of flappy
    vy = 0; % y velocity of flappy
    th = 0; % angle of flappy
    alive = 0;
    state = 'idle';
    world = [];
    controller = [];
    
    hgt = [];
    h = [];
    
    sounds = struct('flap',[],'die',[],'score',[]);
end

methods
    function self = FlappyCover(w,k)
        self@handle();
        self.world = w;
        self.controller = k;
        self.state = 'active';
        self.alive = 1;
        
        self.hgt = hgtransform('Parent',self.world.ax);
        [X,map,alpha] = imread('images/flappycover.png');
        self.h = image('CData',X,'AlphaData',alpha,'Parent', ...
            self.hgt,'XData',[-31 32],'YData',[32 -31]);
        
        [Y,FS] = audioread('sounds/flap.wav');
        self.sounds.flap = audioplayer(Y,FS);
        [Y,FS] = audioread('sounds/hurt.wav');
        self.sounds.die = audioplayer(Y,FS);
        [Y,FS] = audioread('sounds/score.wav');
        self.sounds.score = audioplayer(Y,FS);
    end
    
    function update(self)
        switch self.state
            case 'idle'
            case 'active'
                if self.controller.flap
                    disp('flap!');
                    self.sounds.flap.play();
                    self.controller.flap = 0;
                    self.vy = 200;
                else
                    self.vy = self.vy+30*(-9.81)*self.world.dt;
                end
                self.x = self.x + self.vx*self.world.dt;
                self.y = self.y + self.vy*self.world.dt;
                self.th = atan2(self.vy/10,self.vx);
                T = makehgtform('translate',self.x,self.y,0,'zrotate',self.th);
                self.hgt.Matrix = T;
            case 'die'
                self.vx = 0;
                self.sounds.die.play();
                self.state = 'dying';
            case 'dying'
                self.vy = self.vy+30*(-9.81)*self.world.dt;
                self.y = self.y + self.vy*self.world.dt;
                self.th = atan2(self.vy,self.vx);
                T = makehgtform('translate',self.x,self.y,0,'zrotate',self.th);
                self.hgt.Matrix = T;
                if self.y<0
                    self.state = 'dead';
                end
            case 'dead'
                self.alive = 0;
        end
    end
end

end
