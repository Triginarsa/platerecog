function move_to_train( is_correct, result, user_input, images )
%MOVE_TO_TRAIN Summary of this function goes here
%   Detailed explanation goes here
result = num2cell(result);
user_input = num2cell(user_input);

if strlength(result) ~= strlength(user_input)
    error('Input length not match');
end

if (is_correct == 0)
    for i = 1:strlength(result)
        if result{i} == user_input{i}
            imwrite(images{i}, sprintf('dataset/%s/%d.bmp', user_input{i}, numel(dir(sprintf('dataset/%s/*.bmp', user_input{i}))) + 1));            
        else
            imwrite(images{i}, sprintf('dataset/%s/%d.bmp', user_input{i}, numel(dir(sprintf('dataset/%s/*.bmp', user_input{i}))) + 1));
        end
    end
else
    for i = 1:strlength(result)
        imwrite(images{i}, sprintf('dataset/%s/%d.bmp', user_input{i}, numel(dir(sprintf('dataset/%s/*.bmp', user_input{i}))) + 1));
    end
end

return;
end