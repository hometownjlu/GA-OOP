% �������Ծ���
TM = getTestMatrix();
% ���Կ�ʼ
for i = 1:length(TM)
    % ���±���
    V = Const.V;
    V.updateVariable(TM(i, :));

    SPT = doOneSPT();% ��һ��SPT
    GA = doTenGA();% ��10��GA
    LBGA = doTenLBGA();% ��10��LBGA
    ALBGA = doTenALBGA();% ��10��ALBGA
    
    best = min([SPT(1, :), GA(1, :), LBGA(1, :), ALBGA(1, :)]);
    TM(i, 5) = calculateRE(SPT(1, 1), best);
    TM(i, 6) = SPT(2, 1);
    
    reGA = calculateRE(GA(1, :), best);
    TM(i, 7) = min(reGA);
    TM(i, 8) = max(reGA);
    TM(i, 9) = mean(reGA);
    TM(i, 10) = mean(GA(2, :));
    
    reLBGA = calculateRE(LBGA(1, :), best);
    TM(i, 11) = min(reLBGA);
    TM(i, 12) = max(reLBGA);
    TM(i, 13) = mean(reLBGA);
    TM(i, 14) = mean(LBGA(2, :));
    
    reALBGA = calculateRE(ALBGA(1, :), best);
    TM(i, 15) = min(reALBGA);
    TM(i, 16) = max(reALBGA);
    TM(i, 17) = mean(reALBGA);
    TM(i, 18) = mean(ALBGA(2, :));
end

function ret = calculateRE(a, b)
    % ����a�����b�����ƫ����a�����飬����ֵҲ������
    
    ret = zeros(1, length(a));
    for i = 1:length(a)
        ret(1, i) = (a(1, i) - b) / b * 100;
    end
end

function ret = getTestMatrix()
    F = [2, 3, 4];
    M1 = [4, 6, 8];
    M2 = [3, 4, 6];
    N = [50, 75, 100];

    LF = length(F);
    LM = length(M1);
    LN = length(N);
    ret = zeros(LF * LM * LN, 18);% test matrix

    for i = 1:LF
        for j = 1:LM
            for k = 1:LN
                row = (i - 1) * LM * LN + (j - 1) * LN + k;
                ret(row, 1:4) = [F(i), M1(j), M2(j), N(k)];
            end
        end
    end
end

function ret = doOneSPT()
    ret = zeros(2, 1);
    tic;
    ret(1, 1) = 10000 / Strategy.SPT(false);
    ret(2, 1) = toc;
end

function ret = doTenGA()
    ret = zeros(2, 10);
    for i = 1:10
        tic;
        ret(1, i) = 10000 / Strategy.GA(false);
        ret(2, i) = toc;
    end
end

function ret = doTenLBGA()
    ret = zeros(12, 10);
    for i = 1:10
        tic;
        ret(1, i) = 10000 / Strategy.LBGA(false);
        ret(2, i) = toc;
    end
end

function ret = doTenALBGA()
    ret = zeros(1, 10);
    for i = 1:10
        tic;
        ret(1, i) = 10000 / Strategy.ALBGA(false);
        ret(2, i) = toc;
    end
end