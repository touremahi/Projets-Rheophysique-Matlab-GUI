function [] = sauver(data,ent)
    % Sauvegarder les données collecter
    %%
%     uiputfile('*.txt', 'Enregistrer les données...');
        [nom, chemin, filind] = uiputfile( ...
       {'*.txt','Fichier Texte (*.txt)'; ...
        '*.xls','Classeur Excel (*.xls)'; ...
        '*.*',  'All Files (*.*)'}, ...
        'Save as', 'Untitled.txt');
    
    if isequal(nom,0) || isequal(chemin,0)
       disp('Données non enregistrées')
    else
        disp(['Données enregistrées sous : ', fullfile(chemin, nom)])
        fichier=[chemin,nom];
        taille=size(data);   
        if (filind==1)||(filind==3)
            save(fichier,'','-ascii','-tabs');
            %%
            fid=fopen(fichier,'w');
            % entete
            fprintf(fid,ent);
            fprintf(fid,['nom du fichier : ',nom,'\r\n\r\n']);
            if taille(2)<3
                fprintf(fid,'%10s\t%10s\t%15s\r\n','Temps (s)','Masse(g)');
                for i=1:taille(1)
                            fprintf(fid,'%10.5f\t%10.5f\r\n',data(i,:));
                end
            elseif taille(2)==3
                fprintf(fid,'%10s\t%10s\t%15s\r\n','Temps (s)','Masse(g)','Position (mm)');
                for i=1:taille(1)
                            fprintf(fid,'%10.5f\t%10.5f\t%15.5f\r\n',data(i,:));
                end
            else
                fprintf(fid,'%10s\t%10s\t%10s\t%15s\r\n','Temps (s)','Masse1(g)','Masse2(g)','Position (mm)');
                for i=1:taille(1)
                            fprintf(fid,'%10.5f\t%10.5f\t%10.5f\t%15.5f\r\n',data(i,:));
                end
            end
            fclose(fid);
        else
            sheet = 1;
            en={ent};
            xlswrite(fichier,en,sheet,'A1');
            if taille(2)<=3
                A = {'Temps (s)','Masse (g)','Position (mm)'};
                xlrange=['A3:C',num2str(taille(1)+2)];
            else
                A = {'Temps (s)','Masse1 (g)','Masse2 (g)','Position (mm)'};
                xlrange=['A3:D',num2str(taille(1)+2)];
            end
            xlswrite(fichier,A,sheet,'A2');
            xlswrite(fichier,data,sheet,xlrange);
%             xlswrite(fichier,data(:,2),sheet,'B2');
%             xlswrite(fichier,data(:,3),sheet,'C2');
        end
    end
end