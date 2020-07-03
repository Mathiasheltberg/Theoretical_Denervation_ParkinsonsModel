clear all; close all; clc


F1 = [     5   330
    6   103
    7     2
    11     3
    15     5
    16     4
    19     6
    22     3
    27     4
    28     5
    33     5
    34     6
    40     6
    42     5
    49     5
    52     4
    54     4
    59     4
    63     3
    68     6
    73     5
    78     5
    81     4
    86     5
    89     7
    95     8
    99    11
    104    14
    108    17
    113    20
    118    27
    121    35
    125    43
    130    52
    133    62
    137    71
    140    81
    145    90
    148   100
    151   109
    154   117
    158   125
    162   132
    165   139
    168   146
    171   151
    173   157
    177   162
    179   167
    182   172
    185   176
    187   182
    190   185
    192   188
    195   192
    197   196
    199   199
    202   203
    203   206
    205   208
    207   211
    209   214
    211   215
    213   219
    216   221
    217   222
    218   225
    220   228
    222   229
    223   231
    224   233
    226   236
    228   237
    229   238
    230   239
    232   242
    233   242
    234   245
    236   246
    237   247
    238   249
    239   250
    240   252
    242   253
    243   254
    244   255
    244   257
    246   257
    247   259
    247   260
    249   261
    249   261
    251   263
    252   263
    252   264
    253   265
    254   266
    255   267
    256   267
    257   268
    257   269
    257   270
    259   271
    258   271
    260   272
    260   273
    261   273
    262   274
    263   275
    264   276
    263   276
    264   277
    265   277
    266   279
    266   280
    267   279
    267   280
    268   281
    268   282
    269   282
    270   283
    270   283
    270   282
    271   284
    272   284
    272   285
    273   285
    273   285
    273   286
    274   287
    274   287
    275   288
    275   288
    275   289
    275   289
    275   289
    277   288
    276   290
    277   290
    278   291
    278   291
    279   292
    279   292
    278   292
    280   293
    280   293
    280   294
    280   294
    281   293
    281   294
    282   295
    281   294
    282   296
    282   296
    283   296
    282   296
    283   296
    284   296
    285   297
    285   297
    285   297
    285   297
    285   298
    285   298
    285   299
    286   299
    286   299
    286   299
    287   300
    286   301
    287   299
    287   301
    287   300
    288   301
    288   301
    288   301
    288   302
    289   302
    288   302
    288   302
    289   303
    289   302
    289   303
    290   303
    289   303
    290   304
    290   303
    290   304
    291   304
    290   305
    291   305
    291   304
    292   304
    291   305
    291   305
    292   305
    292   305
    292   306
    293   306
    292   306
    293   306]

Nue = [1 3 6 10 13 16 20 25 30 35 40];
Mme1 = zeros(length(Nue),3);
Msd1 = zeros(length(Nue),3);
Mme2 = zeros(length(Nue),3);
Msd2 = zeros(length(Nue),3);

for nni = 1:length(Nue);
    nni
    in = 1; out = 1; nRem = Nue(nni);
    load(['../P',num2str(in),'.mat'],'P1');
    for test = 1:3
        if test == 1;
            load(['../Rand/Remaining_',num2str(nRem),'_DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
        elseif (test==2)
            load(['../Spread/Remaining_',num2str(nRem),'_DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
        elseif (test == 3)
            load(['../Stress/Remaining_',num2str(nRem),'_DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
        else
            DK = linspace(1,100000,100000)';
        end
        
        ND = find(DK);
        a = 0.3; b = 1.5; c = 2.1;
        P1n = P1(ND,:);
        
        ac = zeros(10000,1); M = [];
        for i = 1:10000
            
            x = -a + 2*a*rand;
            y = -b + 2*b*rand;
            z = -c + 2*c*rand;
            
            while (x^2/a^2 + y^2/b^2 + z^2/c^2 > 1)
                x = -a + 2*a*rand;
                y = -b + 2*b*rand;
                z = -c + 2*c*rand;
            end
            Pn = [x, y, z]';
            dd = sqrt( (P1n(:,1)-Pn(1)).^2 + (P1n(:,2)-Pn(2)).^2 + (P1n(:,3)-Pn(3)).^2);
            n1 = find(dd < 0.05);
            n = 1 + poissrnd(length(n1)*10); if (n>201); n=201; end
            if (n>1)
                ac1(i) = F1(n,1);
                ac2(i) = F1(n,2);
            else
                ac1(i) = F1(1,1);
                ac2(i) = F1(1,2);
            end
            
            
        end
        Mme1(nni,test) = mean(ac1);
        Msd1(nni,test) = std(ac1);
        Mme2(nni,test) = mean(ac2);
        Msd2(nni,test) = std(ac2);
    end
    
end
Nue = flip(Nue);
figure; plot(Nue',smooth(Mme1(:,1)),'color',[0.1 0.1 0.7],'LineWidth',3); hold on;
plot(Nue',smooth(Mme1(:,2)),'color',[0.7 0.1 0.1],'LineWidth',3);
plot(Nue',smooth(Mme1(:,3)),'color',[0.1 0.7 0.1],'LineWidth',3); goodplot;
axis([0 45 0 300])


figure; plot(Nue',smooth(Mme2(:,1)),'color',[0.1 0.1 0.7],'LineWidth',3); hold on; 
plot(Nue',smooth(Mme2(:,2)),'color',[0.7 0.1 0.1],'LineWidth',3); 
plot(Nue',smooth(Mme2(:,3)),'color',[0.1 0.7 0.1],'LineWidth',3);   goodplot;
axis([0 45 0 300])

figure; plot(Nue',smooth(Msd1(:,1)),'color',[0.1 0.1 0.7],'LineWidth',3); hold on; 
plot(Nue',smooth(Msd1(:,2)),'color',[0.7 0.1 0.1],'LineWidth',3); 
plot(Nue',smooth(Msd1(:,3)),'color',[0.1 0.7 0.1],'LineWidth',3); goodplot;
axis([0 45 0 300])

figure; plot(Nue',smooth(Msd2(:,1)),'color',[0.1 0.1 0.7],'LineWidth',3); hold on; 
plot(Nue',smooth(Msd2(:,2)),'color',[0.7 0.1 0.1],'LineWidth',3); 
plot(Nue',smooth(Msd2(:,3)),'color',[0.1 0.7 0.1],'LineWidth',3);   goodplot;
axis([0 45 0 300])