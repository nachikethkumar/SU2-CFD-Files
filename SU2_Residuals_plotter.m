file = readmatrix('history.csv');  % replace with your filename
sheet = 'Sheet1';           % replace with your sheet name= file([2,:],1)          
 % replace with your range of data
 % Create axes for the 5 line graphs
 f=figure;

Rho_axes = subplot(2,3,1);
RhoU_axes = subplot(2,3,2);
RhoV_axes = subplot(2,3,3);
RhoE_axes = subplot(2,3,4);
Rhonu_axes = subplot(2,3,5);
All_axes = subplot(2,3,6);

while true
    file = readmatrix('history.csv');

   

    % Read data from Excel file
    iter = file(:,3);
    Rho = file(:,4);
    RhoU = file(:,5);
    RhoV = file(:,6);
    RhoE = file(:,7);
    Rhonu = file(:,8);
    % Plot data
   % refreshdata(iter);
   
    plot(Rho_axes,iter, Rho,"r");
    xlabel(Rho_axes, 'Iteration');
ylabel(Rho_axes, 'Rho');
title(Rho_axes, 'Rho vs Iteration');
    % refreshdata(Rho);
    hold on
    plot(RhoU_axes,iter, RhoU,'b');
    xlabel(RhoU_axes, 'Iteration');
ylabel(RhoU_axes, 'RhoU');
title(RhoU_axes, 'RhoU vs Iteration');
    % refreshdata(RhoU);
    hold on
    plot(RhoV_axes,iter, RhoV,'g');

xlabel(RhoV_axes, 'Iteration');
ylabel(RhoV_axes, 'RhoV');
title(RhoV_axes, 'RhoV vs Iteration');
    % refreshdata(RhoV);
    hold on
    plot(RhoE_axes,iter, RhoE,'k');

xlabel(RhoE_axes, 'Iteration');
ylabel(RhoE_axes, 'RhoE');
title(RhoE_axes, 'RhoE vs Iteration');
   %  refreshdata(RhoE);
    hold on
    plot(Rhonu_axes,iter, Rhonu,'c');

xlabel(Rhonu_axes, 'Iteration');
ylabel(Rhonu_axes, 'Rho NU');
title(Rhonu_axes, 'Rho NU vs Iteration');
   % refreshdata(Rhonu);
    hold on

    plot(All_axes,Rho,"r");
    hold on
     plot(All_axes,iter, RhoU,'b');
    % refreshdata(RhoU);
    hold on
    plot(All_axes,iter, RhoV,'g');
    % refreshdata(RhoV);
    hold on
    plot(All_axes,iter, RhoE,'k');
   %  refreshdata(RhoE);
    hold on
    plot(All_axes,iter, Rhonu,'c');

    xlabel(All_axes, 'Iteration');
ylabel(All_axes, 'Resudals');
title(All_axes, 'Resudals');

   % refreshdata(Rhonu);

   % xlabel('Iteration');
    %ylabel('Residuals');
   % title('RESIDUALS');
   % legend('Rho','rmsRhoU','rmsRhoV','rmsRhoE','rmsRho nu');
    
    % Pause for a short time to allow Excel file to update
   % pause(0.1);
    drawnow;
end
%}


%{

% Open a serial connection to the device
s = serial('COM13', 'BaudRate', 115200);
fopen(s);

% Create a figure
f = figure;

% Create the first table
t1 = uitable(f, 'Data', zeros(1,4), 'ColumnName', { 'Latitude', 'Longitude', 'Temperature','Altitude'}, 'RowName', {''}, 'Position', [1000 150 500 90]);
t1.FontSize = 16;
t1.ColumnWidth = {100, 150, 150, 100};

% Create the second table
t2 = uitable(f, 'Data', zeros(1,4), 'ColumnName', { 'Recording', 'Saving to SD card', 'Satellite ID','Packets'}, 'RowName', {''}, 'Position', [1000 60 500 90]);
t2.FontSize = 16;
t2.ColumnWidth = { 100, 100, 150, 150};

% Create axes for the 5 line graphs
latitude_axes = subplot(2,3,1);
longitude_axes = subplot(2,3,2);
temperature_axes = subplot(2,3,3);
altitude_axes = subplot(2,3,4);
Packets_axes = subplot(2,3,5);

% Add labels, titles, and limits to each subplot
xlabel(latitude_axes, 'Iteration');
ylabel(latitude_axes, 'Latitude');
title(latitude_axes, 'Latitude vs Iteration');
xlabel(longitude_axes, 'Iteration');
ylabel(longitude_axes, 'Longitude');
title(longitude_axes, 'Longitude vs Iteration');
xlabel(temperature_axes, 'Iteration');
ylabel(temperature_axes, 'Temperature');
title(temperature_axes, 'Temperature vs Iteration');
xlabel(altitude_axes, 'Iteration');
ylabel(altitude_axes, 'Altitude');
title(altitude_axes, 'Altitude vs Iteration');
xlabel(Packets_axes, 'Iteration');
ylabel(Packets_axes, 'Pressure');
title(Packets_axes, 'Pressure vs Iteration');

% Initialize arrays to store the data for each line graph
latitude_data = [];
longitude_data = [];
temperature_data = [];
altitude_data = [];
Packets_data = [];
time = [];
start_time = tic; % Start a timer to keep track of the elapsed time

% Start a while loop for continuously reading data
while true
% Read the data from the port
data = fscanf(s);
% Split the data into 9 separate variables
    %[gsx, latitude, longitude, temperature, altitude, recording, saving, satellite_id, Packets] = strread(data, '%s%f%f%f%f%f%d%d%d', 1, 'delimiter', ',');
     [gsx, latitude, longitude, temperature, altitude, recording, saving, NEWdata1, satellite_id, NEWdata2, Packets] = strread(data, '%s%f%f%f%f%f%d%d%d%d%d', 1, 'delimiter', ',');

    % Update the table with the latest data
    set(t1, 'Data', [latitude, longitude, temperature, altitude]);
    set(t2, 'Data', [recording, saving, satellite_id, Packets]);

    % Update the arrays for each line graph with the latest data
    latitude_data = [latitude_data, latitude];
    longitude_data = [longitude_data, longitude];
    temperature_data = [temperature_data, temperature];
    altitude_data = [altitude_data, altitude];
    Packets_data = [Packets_data, Packets];
    %start_time = tic; % Start a timer to keep track of the elapsed time
    %elapsedTime 
    time(end+1)= toc(start_time);
    %time = [time, start_time ];
    
    
    % Plot the data for each line graph
    plot(latitude_axes, time, latitude_data, '-');
   xlabel('Time');
   ylabel( 'Latitude');
   title( 'Latitude vs Iteration');
   hold on

    plot(longitude_axes, time, longitude_data, '-');
    xlabel( 'Time');
    ylabel('Longitude');
    title('Longitude vs Iteration');
   hold on

    plot(temperature_axes, time, temperature_data, '-');
    xlabel('Time');
    ylabel('Temperature');
    title( 'Temperature vs Iteration');
    hold on

    plot(altitude_axes, time, altitude_data, '-');
    xlabel( 'Time');
    ylabel( 'Altitude');
    title( 'Altitude vs Iteration');
    hold on

     plot(Packets_axes, time, Packets_data, '-');
     xlabel('Time');
     ylabel('Packets');
     title('Packets vs Iteration');
     hold on
     
    % Refresh the figure to show the updated data
    drawnow;
end

% Close the serial connection
%fclose(s);
%}

%{
% Set up the serial object
s = serial('COM1'); % Replace 'COM1' with the correct port name
set(s, 'BaudRate', 9600);
fopen(s);

% Create a figure window
f = figure;

% Create a table to display the data
data_table = uitable('Data', zeros(1,6), 'ColumnName', {'x cor', 'y cor', 'z cord', 'temp', 'pressu', 'alti'}, ...
                     'RowName', [], 'Position', [10 10 500 500]);

% Create a button to close the program
close_button = uicontrol('Style', 'pushbutton', 'String', 'Close', 'Position', [10 10 50 20], ...
                         'Callback', @(src, event) close_callback(src, event, s));

% Read data from the USB port and update the table
while ishandle(f)
    data = fscanf(s, '%f,%f,%f,%f,%f,%f');
    set(data_table, 'Data', [get(data_table, 'Data'); data]);
    drawnow;
end

% Close the serial object
fclose(s);
delete(s);
clear s;

% Callback function for the close button
function close_callback(src, event, s)
    delete(get(src, 'Parent'));
    fclose(s);
    delete(s);
    clear s;
end
%}
