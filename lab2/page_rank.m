function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
numer_indeksu = 193630;
Edges = [1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 7; 
         4, 6, 3, 4, 5, 5, 6, 7, 5, 6, 4, 6, 4, 7, 6];

L1 = 3;
L2 = 6;
N = 8;

Edges = [Edges, [8, mod(L2, 7) + 1; 
                 mod(L1, 7) + 1, 8]];
I = speye(N);
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);

A_data = 1 ./ sum(B, 1);
A  = spdiags(A_data', 0, N, N);

d = 0.85;

b = ((1 - d) / N) * ones(N, 1);

M = I - d * B * A;
r = mldivide(M, b);

end