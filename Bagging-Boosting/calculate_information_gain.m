% Jun Xie
% xie@eecs.oregonstate.edu

%calculate the information gain
function information_gain = calculate_information_gain(data, weight)

% calculate the number of instance and features, in our case, there are 22
[instance_number, feature_number] = size(data);

% for each feature, calculate its mutual information
for i = 2 : feature_number

        if nargin == 2 

                llabel = data(data(:,i)==0,:);
                rlabel = data(data(:,i)==1,:);
                lweight = weight(data(:,i)==0);
                rweight = weight(data(:,i)==1);

                pi0l0 = sum(lweight(llabel(:,1)==0));
                pi0l1 = sum(lweight(llabel(:,1)==1));
                temp1 = pi0l0+pi0l1;

                pi0l0 = pi0l0/temp1;
                pi0l1 = pi0l1/temp1;
                pi1l0 = sum(rweight(rlabel(:,1)==0));

                pi1l1 = sum(rweight(rlabel(:,1)==1));
                temp2 = pi1l0+pi1l1;
                pi1l0 = pi1l0/temp2;
                pi1l1 = pi1l1/temp2;

                if pi0l0==0 || pi0l1==0
                        entropyi0 = 0;
                else    
                entropyi0 = -pi0l0*log2(pi0l0)-pi0l1*log2(pi0l1);
                end     
                if pi1l0==0 || pi1l1==0
                entropyi1 = 0;  
                else    
                        entropyi1 = -pi1l0*log2(pi1l0)-pi1l1*log2(pi1l1);
                end     
                information_gain(i-1) = sum(weight(data(:,i)==0))*(entropyi0) + sum(weight(data(:,i)==1))*(entropyi1);
        elseif nargin == 1        
                if (isempty(find(data(:,i) == 0, 1)) || isempty(find(data(:,i) == 1, 1)))  
                        information_gain(i-1) = 1;
                else
                        information_gain(i-1) = (length(find(data(:,i)==0))*entropy(data(data(:,i)==0,1))+length(find(data(:,i)==1))*entropy(data(data(:,i)==1,1)))/size(data,1);
                end
        end
end
