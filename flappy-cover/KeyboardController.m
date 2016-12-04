classdef KeyboardController < handle
    
    properties
        flap = 0;
        fig = [];
    end % properties
    
    methods
        function self = KeyboardController(fig)
            self@handle(); % call superclass constructor
            self.fig = fig;
            self.fig.KeyPressFcn = @self.keypressed;
        end
        
        function keypressed(self, fig, eventdata)
            % keypressed callback function
            switch eventdata.Key
                case 'space'
                    self.flap  = 1;
            end
        end

    end % instance methods
end % classdef KeyboardController

