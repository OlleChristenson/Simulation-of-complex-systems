function PlotSpace(agentsLocation, t)

    
    plot(agentsLocation.S(:,1), agentsLocation.S(:,2), '.b',agentsLocation.I(:,1), agentsLocation.I(:,2), '.r', agentsLocation.R(:,1), agentsLocation.R(:,2), '.g')
    title("Time step = "+t)
    axis([1 100 1 100]);
    xticks([])
    yticks([])
    xlabel('x')
    ylabel('y')
    drawnow;
end
