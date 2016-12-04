classdef World < handle

  properties
      fig = []; % world will eventually have a figure
      ax = [];  % and an axis for plotting
      dt = 1/20;
      
      pipex = [0 0.9 1 1.1 1.2 
      lb = [
      themes = struct('main',[],'death',[],'win',[]);
  end

  methods
      function self = World()
          % constructor for the FlappyCover World
          self@handle();
          self.fig = figure();
          self.ax = axes(self.fig, 'Position',[0 0 1 1]);
          self.ax.DataAspectRatio = [1 1 1]; % set to have axis equal
          self.ax.XLim = [-320 6400];
          self.ax.YLim = [-20 480];
          self.ax.Color = [0.7 0.7 1];
          self.dt = 1/20;

          grass = rectangle(self.ax,'Position',[-320 -30 6400 30],'FaceColor',[240 230 140]/255,...
              'EdgeColor','g','LineWidth',2);
          
          
          [Y,FS] = audioread('sounds/usmchymn.wav');
          self.themes.main = audioplayer(Y,FS);
          [Y,FS] = audioread('sounds/carryon.wav');
          self.themes.death = audioplayer(Y,FS);
      end
      
      function update_view(self,x)
          % move view to where Flappy is
          self.ax.XLim = [-320 320]+x;
      end
      
      function view_all(self)
          % view the whole world
          self.ax.XLim = [-320 6400];
      end
      
  end % instance methods

end %classdef World
