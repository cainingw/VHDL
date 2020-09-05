# RC5

This project use RC5 to decode and encode a message. 
You can test the result at here: https://asecuritysite.com/encryption/rc5

# Function:

A = A + S[0]
B = B + S[1]
for i = 1 to 12 do
A = ((A xor B) <<< B) + S[2×i];
B = ((B xor A) <<< A) + S[2×i + 1];

# INVERSE OF THE FUNCTION:

A = A – S[0]
B = B – S[1]
for i = 12 downto 1 do
B = ((B - S[2×i +1]) >>> A) xor A;
A = ((A - S[2×i]) >>> B) xor B;