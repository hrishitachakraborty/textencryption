n = 221;
d = 77;
decryptionStartTime = tic;
decryptionTime = toc(decryptionStartTime);
% Steganalysis (obtaining ciphertext from image)

stegoImage = imread("stego_image.png");

messageLength = bit2int(bitget(stegoImage(1, 1:8, 1), 1)', 8) + 1;
res = zeros(1, messageLength-1);
outputInd = 1;
for ind = 9:8:messageLength*8
    i = floor(ind/height)+1;
    j = mod(ind-1, width)+1;
    y = bit2int(bitget(stegoImage(i, j:j+7, 1), 1)', 8);
    res(outputInd) = y;
    outputInd = outputInd + 1;
end

disp("Extracted Ciphertext: " + char(res));
disp("Decrypted text: " + char(powermod(res, d, n)))
