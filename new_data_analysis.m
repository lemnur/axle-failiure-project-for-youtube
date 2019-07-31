% this is the newest data
clear all;
clc;
accel_data = readtable('RR100finalforthis.csv');



%% seperating the data with # and $
k = strfind(accel_data.Var1,'#');% finding the character # which has the info from IMU
for i = 1:length(k)
   if (k{i} == 1)
      place_holder(i) = i; 
   end
end
place_holder = place_holder'; % this has all the position of hashes 
for i = 1:length(place_holder)
    if (place_holder(i) ~= 0)
       elasped_time(i) =  accel_data.Var1(i);
      event(i) = accel_data.Var2(i);
        roll(i) = accel_data.Var3(i);
       pitch(i) = accel_data.Var4(i);
       yaw(i) = accel_data.Var5(i);
       GX(i) = accel_data.Var6(i);
       GY(i) = accel_data.Var7(i);
       GZ(i) = accel_data.Var8(i);
       % the other ones
        date{i} = 0;
        time(i) = 0;
        latitude(i) = 0;
        longitude(i) = 0;
        altitude(i) = 0;
        speed(i) = 0;
        bearing(i) = 0;
        no_of_satellites(i) = 0; 
    else 
   elasped_time{i} =  0;
      event(i) = 0;
        roll(i) = 0;
       pitch(i) = 0;
       yaw(i) = 0;
       GX(i) = 0;
       GY(i) = 0;
       GZ(i) = 0;
       % now these values are kept
        date(i) = accel_data.Var1(i);
        time(i) = accel_data.Var2(i);
        latitude(i) = accel_data.Var3(i);
        longitude(i) = accel_data.Var4(i);
        altitude(i) = accel_data.Var5(i);
        speed(i) = accel_data.Var6(i);
        bearing(i) = accel_data.Var7(i); 
        no_of_satellites(i) = accel_data.Var8(i); 
    end
end
%% processing the acquired data before and making it all cell data 
elasped_time =  elasped_time';
      event = event';
        roll = roll';
       pitch = pitch';
       yaw = yaw';
       for i = 1:length(GX)
           if ((GX(i) ~= 0)) % 0 values should be skipped
       GX(i) = 0.909.*(GX(i))-1.5;
      
           else 
               GX(i) = 0;
               
           end
       end
       
        for i = 1:length(GY)
           if ((GY(i) ~= 0)) % 0 values should be skipped
       GY(i) = 0.909.*(GY(i))-1.5;
      
           else 
               GY(i) = 0;
               
           end
        end
       
        for i = 1:length(GZ)
           if ((GZ(i) ~= 0)) % 0 values should be skipped
       GZ(i) = 0.909.*(GZ(i))-1.5;
      
           else 
               GZ(i) = 0;
               
           end
        end
       GX = GX';
       GY = GY';
       GZ = GZ';
        date = date';
        time = time';
        latitude = latitude';
        longitude = longitude';
        altitude = (altitude/100)';
        speed = (speed/100)';
        bearing = (bearing/100)';
        no_of_satellites = no_of_satellites';
        % converting the vibration data to cell because later I have to
        % combine them all together 
        event = num2cell(event);
        roll = num2cell(roll);
       pitch = num2cell(pitch);
       yaw = num2cell(yaw);
       GX = num2cell(GX);
       GY = num2cell(GY);
       GZ = num2cell(GZ);
       
       % converting the speed data into cell
       speed(182) = 0; % this is the noise value 
        time = num2cell(time);
        latitude = num2cell(latitude);
        longitude = num2cell(longitude);
        altitude = num2cell(altitude);
        speed = num2cell(speed);
        bearing = num2cell(bearing);
        no_of_satellites = num2cell(no_of_satellites);
% accel_data_cell = table2array(accel_data);
% accel_data_cell_time = accel_data_cell(:,1);
% accel_data_cell_x = accel_data_cell(:,2);
% accel_data_cell_y = accel_data_cell(:,3);
% accel_data_cell_z = accel_data_cell(:,4);

%% making 2 sets of data vibration and velocity data
vibration = [elasped_time, event, roll, pitch, yaw , GX, GY, GZ];
%vibration = cell2table(vibration);
% now making a set for speed data
% speed = cell2mat(speed);
% speed = speed./120 % pleaseeeeeeeeeeeeeeeeee check this from hormoz he has kmh so I thought divide by 120
velocity = [date, time, latitude, longitude, altitude, speed,bearing, no_of_satellites];
%velocity = cell2table(velocity);




%% response variable in vibrations of our data small, medium, large based on mean of the values 
%#######    PLEASE ASK HORMOZ ABOUT THE METHODOLOGY OF THIS PROCEDURE 
% this is done visually 
acceleration_total = [ GX,GY,GZ];
acceleration_total = cell2mat(acceleration_total);
for i = 1:length(acceleration_total)
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration(i) = sqrt(acceleration_total(i,1).^2 + acceleration_total(i,2).^2 + acceleration_total(i,3).^2);
    
    
end
avg_acceleration = avg_acceleration';

%plot(samples, avg_acceleration);


sample = 1:7000;
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_7000(i) = avg_acceleration(i);
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_14000(i) = avg_acceleration(i+7000);
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_21000(i) = avg_acceleration(i+14000);
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_28000(i) = avg_acceleration(i+21000);
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_35000(i) = avg_acceleration(i+28000);
    
    
end

for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_42000(i) = avg_acceleration(i+35000);
    
    
end

for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_49000(i) = avg_acceleration(i+42000);
    
    
end

for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_56000(i) = avg_acceleration(i+49000);
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_63000(i) = avg_acceleration(i+56000);
    
    
end

for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   avg_acceleration_divide_70000(i) = avg_acceleration(i+63000);
    
    
end
figure
plot(sample,avg_acceleration_divide_7000);
title('first 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(sample,avg_acceleration_divide_14000);
title('second 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(sample,avg_acceleration_divide_21000);
title('third 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(sample,avg_acceleration_divide_28000);
title('fourth 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(sample,avg_acceleration_divide_35000);
title('fifth 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(sample,avg_acceleration_divide_42000);
title('sixth 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(sample,avg_acceleration_divide_49000);
title('seventh 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(sample,avg_acceleration_divide_56000);
title('eighth 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(sample,avg_acceleration_divide_63000);
title('ninth 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(sample,avg_acceleration_divide_70000);
title('tenth 7000 rows of average acceleration');
xlabel('samples');
ylabel('m/s^2');
% figure 
% plot(fft(avg_acceleration));
% 
% plot(dft(avg_acceleration));
%% finding the min, mean and max of the divided data set 
min_avg_acceleration(1) = min(avg_acceleration_divide_7000);
min_avg_acceleration(2) = min(avg_acceleration_divide_14000);
min_avg_acceleration(3) = min(avg_acceleration_divide_21000);
min_avg_acceleration(4) = min(avg_acceleration_divide_28000);
min_avg_acceleration(5) = min(avg_acceleration_divide_35000);
min_avg_acceleration(6) = min(avg_acceleration_divide_42000);
min_avg_acceleration(7) = min(avg_acceleration_divide_49000);
min_avg_acceleration(8) = min(avg_acceleration_divide_56000);
min_avg_acceleration(9) = min(avg_acceleration_divide_63000);
min_avg_acceleration(10) = min(avg_acceleration_divide_70000);

min_total = min(min_avg_acceleration);

mean_avg_acceleration(1) = mean(avg_acceleration_divide_7000);
mean_avg_acceleration(2) = mean(avg_acceleration_divide_14000);
mean_avg_acceleration(3) = mean(avg_acceleration_divide_21000);
mean_avg_acceleration(4) = mean(avg_acceleration_divide_28000);
mean_avg_acceleration(5) = mean(avg_acceleration_divide_35000);
mean_avg_acceleration(6) = mean(avg_acceleration_divide_42000);
mean_avg_acceleration(7) = mean(avg_acceleration_divide_49000);
mean_avg_acceleration(8) = mean(avg_acceleration_divide_56000);
mean_avg_acceleration(9) = mean(avg_acceleration_divide_63000);
mean_avg_acceleration(10) = mean(avg_acceleration_divide_70000);

mean_total = mean(mean_avg_acceleration);

median_avg_acceleration(1) = median(avg_acceleration_divide_7000);
median_avg_acceleration(2) = median(avg_acceleration_divide_14000);
median_avg_acceleration(3) = median(avg_acceleration_divide_21000);
median_avg_acceleration(4) = median(avg_acceleration_divide_28000);
median_avg_acceleration(5) = median(avg_acceleration_divide_35000);
median_avg_acceleration(6) = median(avg_acceleration_divide_42000);
median_avg_acceleration(7) = median(avg_acceleration_divide_49000);
median_avg_acceleration(8) = median(avg_acceleration_divide_56000);
median_avg_acceleration(9) = median(avg_acceleration_divide_63000);
median_avg_acceleration(10) = median(avg_acceleration_divide_70000);

median_total = median(median_avg_acceleration);

% mean and median are close to each other the data is evenly distributed
max_avg_acceleration(1) = max(avg_acceleration_divide_7000);
max_avg_acceleration(2) = max(avg_acceleration_divide_14000);
max_avg_acceleration(3) = max(avg_acceleration_divide_21000);
max_avg_acceleration(4) = max(avg_acceleration_divide_28000);
max_avg_acceleration(5) = max(avg_acceleration_divide_35000);
max_avg_acceleration(6) = max(avg_acceleration_divide_42000);
max_avg_acceleration(7) = max(avg_acceleration_divide_49000);
max_avg_acceleration(8) = max(avg_acceleration_divide_56000);
max_avg_acceleration(9) = max(avg_acceleration_divide_63000);
max_avg_acceleration(10) = max(avg_acceleration_divide_70000);

max_total = max(max_avg_acceleration);




avg_acceleration = num2cell(avg_acceleration);


%% visualising the data (vibration average this case and others)
% adding another column of just numbers 
number = 1:length(speed);
number = number';
number = num2cell(number);
data_all_1 = [number, vibration, avg_acceleration ]; %docum
data_all_2 = cell2table(data_all_1);
data_all = tall(data_all_2); % this contains a tall array of our data
% plot some data by only taking 5000 points so that it fits in our memory
samplePlot = datasample(data_all,5000,'Replace',false);
samplePlot = gather(samplePlot);
figure
plot(samplePlot.data_all_11,samplePlot.data_all_17);% the x acceleration
title('x acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(samplePlot.data_all_11,samplePlot.data_all_18);% the y acceleration
title('y acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(samplePlot.data_all_11,samplePlot.data_all_19);% the y acceleration
title('z acceleration');
xlabel('samples');
ylabel('m/s^2');
figure
plot(samplePlot.data_all_11,samplePlot.data_all_110);% the avg acceleration
title('avg acceleration');
xlabel('samples');
ylabel('m/s^2');
%% visualising the data (speed and bearing in this case)
% adding another column of just numbers 
number = 1:length(speed);
number = number';
number = num2cell(number);
data_all_1 = [number, velocity ]; %docum
data_all_2 = cell2table(data_all_1);
data_all = tall(data_all_2); % this contains a tall array of our data
% plot some data by only taking 5000 points so that it fits in our memory
samplePlot = datasample(data_all,5000,'Replace',false);
samplePlot = gather(samplePlot);
figure
plot(samplePlot.data_all_11,samplePlot.data_all_17);% speed
title('speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(samplePlot.data_all_11,samplePlot.data_all_18);% bearing
title('bearing');
xlabel('samples');
ylabel('degrees');
% figure
% plot(samplePlot.data_all_11,samplePlot.data_all_19);% the z acceleration
% title('z acceleration');
% xlabel('samples');
% ylabel('m/s^2');



%% adding average acceleration
vibration = [elasped_time, event, roll, pitch, yaw , GX, GY, GZ, avg_acceleration];
avg_acceleration = cell2mat (avg_acceleration);
% min_avg_acceleration = min(avg_acceleration);
% mean_avg_acceleration = mean(avg_acceleration);
% median_avg_acceleration = median(avg_acceleration);
% max_avg_acceleration = max(avg_acceleration); 
 vibration = cell2table(vibration);
 velocity = cell2table(velocity);
%classificationLearner
%% adding classification data 
%-0.0022 to 0.0022 small acceleration
%-0.0044 to 0.0044 medium acceleration
% -0.6450 to 0.6150 max acceleration 
%avg_acceleration = cell2mat(avg_acceleration);

for i = 1:length(avg_acceleration)
   
    if(avg_acceleration(i) >= min_total && avg_acceleration(i) <= mean_total )
        class_matrixx{i} = 'small';
    
    elseif(avg_acceleration(i) >= mean_total && avg_acceleration(i) <= median_total  )
        class_matrixx{i} = 'moderate';
        
        
    elseif(avg_acceleration(i) >= median_total && avg_acceleration(i) <= max_total  )
        class_matrixx{i} = 'extreme';
        
            else
            end
    
    
end

class_matrixx = class_matrixx';
class_matrixx = num2cell(class_matrixx);

vibration = [vibration, class_matrixx]; % adding the classification part of matrix 


%classificationLearner
%% most accurate knn and easy to train result is 82.5 % accurate this is with pca on

[trainedClassifier, validationAccuracy] = trainClassifier(vibration)
vibration_test = table2cell(vibration);
% for i = 1:9
% vibration_test_table{1,i} = vibration_test{55000,i};
% vibration_test_table{2,i} = vibration_test{53550,i};
% vibration_test_table{3,i} = vibration_test{54500,i};
% vibration_test_table{4,i} = vibration_test{55501,i};
% vibration_test_table{5,i} = vibration_test{53500,i};
% vibration_test_table{6,i} = vibration_test{54500,i};
% 
% 
% end
% for i = 1:6
%     if (i == 1)
%   actual{i} = vibration_test{55000,10};  
%     end
%     if (i == 2)
%   actual{i} = vibration_test{53500,10}; 
%     end
%     if (i == 3)
%     actual{i} =   vibration_test{54500,10}; 
%     end
%      if (i == 4)
%   actual{i} = vibration_test{55001,10};  
%     end
%     if (i == 5)
%   actual{i} = vibration_test{53500,10}; 
%     end
%     if (i == 6)
%     actual{i} =   vibration_test{54500,10}; 
%     end
% end
% actual = actual';

for i = 1:9
vibration_test_table{1,i} = vibration_test{55000,i};
vibration_test_table{2,i} = vibration_test{56550,i};
vibration_test_table{3,i} = vibration_test{60500,i};
vibration_test_table{4,i} = vibration_test{60501,i};
vibration_test_table{5,i} = vibration_test{61500,i};
vibration_test_table{6,i} = vibration_test{63500,i};


end
for i = 1:6
    if (i == 1)
  actual{i} = vibration_test{55000,10};  
    end
    if (i == 2)
  actual{i} = vibration_test{56500,10}; 
    end
    if (i == 3)
    actual{i} =   vibration_test{60500,10}; 
    end
     if (i == 4)
  actual{i} = vibration_test{60501,10};  
    end
    if (i == 5)
  actual{i} = vibration_test{61500,10}; 
    end
    if (i == 6)
    actual{i} =   vibration_test{63500,10}; 
    end
end
actual = actual';

vibration_test_table = cell2table(vibration_test_table);
 vibration_test_table.Properties.VariableNames = {'vibration1' 'vibration2' 'vibration3' 'vibration4' 'vibration5' 'vibration6' 'vibration7' 'vibration8' 'vibration9'}
prediction_knn = trainedClassifier.predictFcn(vibration_test_table);


%% pca off (dont want to reduce the dimensions and we get 100% accuracy of predicting the range of vibration with the given data
[trainedClassifier, validationAccuracy] = trainClassifier_100(vibration)
% the hold out value is 25% of the data that means after row 52,500 is new
% to this data set 
prediction_tree = trainedClassifier.predictFcn(vibration_test_table);



%% svm classification 
[trainedClassifier, validationAccuracy] = trainClassifier_vibration_svm(vibration)
prediction_vibration_svm = trainedClassifier.predictFcn(vibration_test_table);

% %% visualising the data (vibration in this case in frequency domain
% % adding another column of just numbers 
% number = 1:length(speed);
% number = number';
% number = num2cell(number);
% data_all_1 = [number, vibration ]; %docum
% data_all_2 = cell2table(data_all_1);
% data_all = tall(data_all_2); % this contains a tall array of our data
% % plot some data by only taking 5000 points so that it fits in our memory
% samplePlot = datasample(data_all,5000,'Replace',false);
% samplePlot = gather(samplePlot);
% figure
% plot(fft(samplePlot.data_all_17));% the x acceleration
% title('x acceleration');
% figure
% plot(fft(samplePlot.data_all_18));% the y acceleration
% title('y acceleration');
% figure
% plot(fft(samplePlot.data_all_19));% the z acceleration
% title('z acceleration');

%% SVM TAKES TOO LONG TO TRAIN using decision tree 
%appdesigner
[trainedClassifier, validationAccuracy] = trainClassifier_without_vibration(vibration)
prediction_knn_no_vibration = trainedClassifier.predictFcn(vibration_test_table);




%% svm on 5000 data set to show its advantage over other algorhythms
vibration_5000 = vibration;
vibration_5000([1000:71842],:) = []; % deleting over 5000 rows 
classificationLearner
% svm has the same accuracy as KNN and fine tree algorhythms in predicting
% vibrations , just with the larger data set it does not perform so well
% and takes a lot of computational power 

%% visualising the data with all the data available via fft
% GX = cell2mat(GX);
% x_acceleration_freq = fft(GX);
% figure
% plot(x_acceleration_freq);
% title('x acceleration in freq');
% 
% GY = cell2mat(GY);
% figure
% y_acceleration_freq = fft(GY);
% plot(y_acceleration_freq);
% title('y acceleration in freq');
% 
% GZ = cell2mat(GZ);
% figure
% z_acceleration_freq = fft(GZ);
% plot(z_acceleration_freq);
% title('z acceleration in freq');
% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^doing speed now 
%% response variable in vibrations of our data small, medium, large based on mean of the values 
 
% this is done visually 
speed = cell2mat(speed);



%plot(samples, avg_acceleration);


sample = 1:7000;
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   speed_divide_7000(i) = speed(i);
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   speed_divide_14000(i) = speed(i+7000);
 
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   
   speed_divide_21000(i) = speed(i+14000);
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   
     speed_divide_28000(i) = speed(i+21000);
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
  
   speed_divide_35000(i) = speed(i+28000);
    
    
end

for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
  
   speed_divide_42000(i) = speed(i+35000);
    
    
end

for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   
   speed_divide_49000(i) = speed(i+42000);
    
    
end

for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
  
    speed_divide_56000(i) = speed(i+49000);
    
    
end
for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
   
   speed_divide_63000(i) = speed(i+56000);
    
    
end

for i = 1:7000
   % avg_acceleration(i) = mean(acceleration_total(i));
 
   speed_divide_70000(i) = speed(i+63000);
    
    
end
figure
plot(sample,speed_divide_7000);
title('first 7000 rows of speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(sample,speed_divide_14000);
title('second 14000 rows of speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(sample,speed_divide_21000);
title('first 21000 rows of speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(sample,speed_divide_28000);
title('first 28000 rows of speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(sample,speed_divide_35000);
title('first 35000 rows of speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(sample,speed_divide_42000);
title('first 42000 rows of speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(sample,speed_divide_49000);
title('first 49000 rows of speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(sample,speed_divide_56000);
title('first 56000 rows of speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(sample,speed_divide_63000);
title('first 63000 rows of speed');
xlabel('samples');
ylabel('km/hr');
figure
plot(sample,speed_divide_70000);
title('first 70000 rows of speed');
xlabel('samples');
ylabel('km/hr');
% figure 
% plot(fft(avg_acceleration));
% 
% plot(dft(avg_acceleration));
%% finding the min, mean and max of the divided data set 
min_speed(1) = min(speed_divide_7000);
min_speed(2) = min(speed_divide_14000);
min_speed(3) = min(speed_divide_21000);
min_speed(4) = min(speed_divide_28000);
min_speed(5) = min(speed_divide_35000);
min_speed(6) = min(speed_divide_42000);
min_speed(7) = min(speed_divide_49000);
min_speed(8) = min(speed_divide_56000);
min_speed(9) = min(speed_divide_63000);
min_speed(10) = min(speed_divide_70000);

min_total_speed = min(min_speed);

mean_speed(1) = mean(speed_divide_7000);
mean_speed(2) = mean(speed_divide_14000);
mean_speed(3) = mean(speed_divide_21000);
mean_speed(4) = mean(speed_divide_28000);
mean_speed(5) = mean(speed_divide_35000);
mean_speed(6) = mean(speed_divide_42000);
mean_speed(7) = mean(speed_divide_49000);
mean_speed(8) = mean(speed_divide_56000);
mean_speed(9) = mean(speed_divide_63000);
mean_speed(10) = mean(speed_divide_70000);

mean_total_speed = mean(mean_speed);

median_speed(1) = median(speed_divide_7000);
median_speed(2) = median(speed_divide_14000);
median_speed(3) = median(speed_divide_21000);
median_speed(4) = median(speed_divide_28000);
median_speed(5) = median(speed_divide_35000);
median_speed(6) = median(speed_divide_42000);
median_speed(7) = median(speed_divide_49000);
median_speed(8) = median(speed_divide_56000);
median_speed(9) = median(speed_divide_63000);
median_speed(10) = median(speed_divide_70000);

median_total_speed = median(median_speed);

% mean and median are close to each other the data is evenly distributed
max_speed(1) = max(speed_divide_7000);
max_speed(2) = max(speed_divide_14000);
max_speed(3) = max(speed_divide_21000);
max_speed(4) = max(speed_divide_28000);
max_speed(5) = max(speed_divide_35000);
max_speed(6) = max(speed_divide_42000);
max_speed(7) = max(speed_divide_49000);
max_speed(8) = max(speed_divide_56000);
max_speed(9) = max(speed_divide_63000);
max_speed(10) = max(speed_divide_70000);

max_total_speed = max(max_speed);




speed = num2cell(speed);


%% adding classification data for speed 
%-0.0022 to 0.0022 small acceleration
%-0.0044 to 0.0044 medium acceleration
% -0.6450 to 0.6150 max acceleration 
%avg_acceleration = cell2mat(avg_acceleration);
speed = cell2mat(speed);

for i = 1:length(speed)
   
    if(speed(i) >= min_total_speed && speed(i) <= mean_total_speed )
        if (speed(i) == 0)
          class_matrix_speed{i} = 'NA';  
        else
        class_matrix_speed{i} = 'slow';
        end
    
    elseif(speed(i) >= mean_total_speed && speed(i) <= median_total_speed  )
        class_matrix_speed{i} = 'medium';
        
        
    elseif(speed(i) >= median_total_speed && speed(i) <= max_total_speed  )
        class_matrix_speed{i} = 'fast';
        
            else
            end
    
    
end

class_matrix_speed = class_matrix_speed';
class_matrix_speed = num2cell(class_matrix_speed);

velocity = [velocity, class_matrix_speed]; % adding the classification part of matrix 


classificationLearner
%% using svm to predict speed based on location 
[trainedClassifier, validationAccuracy] = trainClassifier_svm_speed(velocity)
speed_test = table2cell(velocity);
for i = 1:8
speed_test_table{1,i} = speed_test{60389,i};
speed_test_table{2,i} = speed_test{60400,i};
speed_test_table{3,i} = speed_test{60410,i};
speed_test_table{4,i} = speed_test{60420,i};
speed_test_table{5,i} = speed_test{60430,i};
speed_test_table{6,i} = speed_test{60440,i};


end
for i = 1:6
    if (i == 1)
  actual_speed{i} = speed_test{60389,9};  
    end
    if (i == 2)
  actual_speed{i} = speed_test{60400,9}; 
    end
    if (i == 3)
    actual_speed{i} =   speed_test{60410,9}; 
    end
     if (i == 4)
  actual_speed{i} = speed_test{60420,9};  
    end
    if (i == 5)
  actual_speed{i} = speed_test{60430,9}; 
    end
    if (i == 6)
    actual_speed{i} =   speed_test{60440,9}; 
    end
end
actual_speed = actual_speed';

speed_test_table = cell2table(speed_test_table);
speed_test_table.Properties.VariableNames = {'velocity1' 'velocity2' 'velocity3' 'velocity4' 'velocity5' 'velocity6' 'velocity7' 'velocity8' }
prediction_svm = trainedClassifier.predictFcn(speed_test_table);

%% predicting speed with tree

[trainedClassifier, validationAccuracy] = trainClassifier_speed_tree(velocity)

speed_test_table.Properties.VariableNames = {'velocity1' 'velocity2' 'velocity3' 'velocity4' 'velocity5' 'velocity6' 'velocity7' 'velocity8' }
prediction_tree_speed = trainedClassifier.predictFcn(speed_test_table);
%% prediciting without speed svm

[trainedClassifier, validationAccuracy] = trainClassifier_svm_without_speed(velocity)

speed_test_table.Properties.VariableNames = {'velocity1' 'velocity2' 'velocity3' 'velocity4' 'velocity5' 'velocity6' 'velocity7' 'velocity8' }
prediction_tree_svm_without_speed_in_data = trainedClassifier.predictFcn(speed_test_table);
%% doing vibration in spectral analysis 
figure
plot(abs(fft(avg_acceleration))); % problem with this is that there is magnitude and phase that is complex numbers 

%pwelch makes spectral analysis easy good for when you dont have much
%information on the data you have 
% with plech we eliminate working with complex numbers 
figure
pwelch(avg_acceleration,[],[],[],200); % sampling frequency is 100 hz we use twice of that to satisfy shanon
% with this we will be able to see periodicity in our data.

% now we will focus on what the square brackets which were left blank mean

% the second square bracket is the window default is hamming window because
% it avoids making a sync function 

%% doing PCA on our data
% because in machine learning it does not understand what are units
Xtrain = data_all{:,3:end}; % take the sensor values regardless of units

%giving the sensor value a mean of 0 and std dev of 1
XtrainMean = mean(Xtrain);
XtrainStd = std(Xtrain);
XtrainStandard = (Xtrain - repmat(XtrainMean,length(Xtrain),1))
D = bsxfun(@rdivide,data_all,sum(data_all));
%% standardising data 
vibration_3 = bsxfun(@rdivide,vibration.vibration3,sum(vibration.vibration3));
vibration_4 = bsxfun(@rdivide,vibration.vibration4,sum(vibration.vibration4));
vibration_5 = bsxfun(@rdivide,vibration.vibration5,sum(vibration.vibration5));
vibration_6 = bsxfun(@rdivide,vibration.vibration6,sum(vibration.vibration6));
vibration_7 = bsxfun(@rdivide,vibration.vibration7,sum(vibration.vibration7));
vibration_8 = bsxfun(@rdivide,vibration.vibration8,sum(vibration.vibration8));
vibration_9 = bsxfun(@rdivide,vibration.vibration9,sum(vibration.vibration9));

vibration_pca = [vibration_3,vibration_4,vibration_5,vibration_6,vibration_7,vibration_8,vibration_9];

[coeff,score,latent] = pca(vibration_pca);
figure 
plot([cumsum(latent(1:7))/sum(latent) latent(1:7)/sum(latent)]*100,'.','MarkerSize',20)
% the above figure shows that first principle component shows all the
% the first principle component explains 95% of our variance
% the second pricniple component explains 5% of our variance 
xlabel('# of principal component');
ylabel('% of variance of data set explained');
legend('Cumulative','Individual')
title('Individual and Cumulative Variance Explained by PCA')

figure
plot(score(:,1),score(:,2),'.');
xlabel('First Principal Component');
ylabel('Second Principal Component');
% after this step you are stuck as you know for sure that your truck did
% not go for a maintainance at this point. if you had more data and you
% could have plotted when it was taken in for the maintainance and compared
% that plot to this pca one to make a section where the truck did not go
% for maintainance. 
% 

