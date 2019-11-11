function [ent]=entete(x,z,ztot,typPale)

dat=clock;
dat=dat(1:5);
date=[num2str(dat(3)),'-',num2str(dat(2)),'-',...
    num2str(dat(1)),' à ',num2str(dat(4)),' h ',num2str(dat(5)),' mn'];
    if ztot==0
        type=['Mesure Statique réalisée le ',date,'\r\n'];
        pos=['Aux positions X = ',num2str(x),...
            ', et Z = ',num2str(z),' mm \r\n' ];
        
    else
        type=['Mesure Dynamique réalisée le ',date,'\r\n'];
        pos=['Aux positions X = ',num2str(x),', et Z = ',num2str(z),...
            ' mm pour une course totale de ',num2str(ztot),' mm \r\n' ];
    end
pale=['Largeur de la pâle : ',num2str(typPale),' mm \r\n' ];

ent=[type,pos,pale];
end