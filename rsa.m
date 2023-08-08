% Encryption Algorithm

% Select two prime numbers
p = 13;
q = 17;

% Calculate modulus
n = p * q;

% Calculate Euler's totient function
phi_n = (p - 1) * (q - 1);

% Calculate the encryption exponent (public key)
e = 5;

% Calculate the decryption exponent (private key)
d = floor((2*phi_n + 1) / e);

% Convert plaintext into ASCII values
plaintext = 'Hello, world!';
messageLength = strlength(plaintext);
asciiValues = double(plaintext);

% Apply encryption formula
encryptionStartTime = tic;
encryptedValues = powermod(asciiValues, e, n);
encryptionTime = toc(encryptionStartTime);

ciphertext = char(encryptedValues);
% Display ciphertext
disp("Ciphertext:");
disp(ciphertext);

% Load the cover image
coverImage = imread('cover_image.jpg');

% Steganography (Embedding)
stegoImage = coverImage; % Create a copy of the cover image for embedding
encryptedValues = [messageLength, encryptedValues]; % add the length of the message into the embed list

bits = int2bit(encryptedValues, 8);
height = size(coverImage, 1);
width = size(coverImage, 2);
for ind = 1:numel(bits)
        i = floor(ind/height)+1;
        j = mod(ind-1, width)+1;
        pixelValue = coverImage(i, j, 1); % Retrieve pixel value
        modifiedPixelValue = bitset(pixelValue, 1, bits(ind)); % Modify LSB of pixel value
        stegoImage(i, j, 1) = uint8(modifiedPixelValue); % Update pixel value in the stego-image
end

imwrite(stegoImage, "stego_image.png");
imshow(stegoImage)

%For calculating mod inverse
function inv = calculateModInverse(a, m)
        % Calculate modular multiplicative inverse using the Extended Euclidean Algorithm

            % Initialize variables
            r1 = m;
            r2 = a;
            s1 = 0;
            s2 = 1;

            while r2 > 0
                quotient = floor(r1 / r2);
                [r1, r2] = deal(r2, mod(r1, r2));
                [s1, s2] = deal(s2, s1 - quotient * s2);
            end

            inv = mod(s1, m);
        end