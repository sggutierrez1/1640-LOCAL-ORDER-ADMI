/****************************************************************************/
/* Autor                : Alfonso Rafael Tlapanco Vaca (ARTV)               */
/****************************************************************************/

/****************************************************************************/
/*                              Headers                                     */
/****************************************************************************/
#include "srvTuxCall.h"
EXEC SQL include sqlca;
struct SQLCA_TYPE sqlca;
short sqlcode;
/****************************************************************************/
/*                          FUNCIONES                                       */
/****************************************************************************/

int tpsvrinit(int argc, char *argv[])
    {
        return 0;
    }

void tpsvrdone( void )
    {

    }

void OPI_TuxCall(TPSVCINFO *rqst)
    {
        EXEC SQL BEGIN DECLARE SECTION;
        long            lNumReg = 0;
        EXEC SQL END DECLARE SECTION;

        char    cCadenaAux[101];
        char    cCadenaSalida[201];

        short   sPresente;
        FBFR32  *pBuffer        = NULL;
        pBuffer = (FBFR32 *)rqst->data;

        if( !Fpres32(pBuffer, STDS_OPE_SOEID, 0))
            {
                Fadd32 ( pBuffer , STDS_OPE_SOEID , "No esta el campo FML STDS_OPE_SOEID", 0 );
            }
        else
            {
                EXEC SQL SELECT COUNT(*)
                INTO :lNumReg
                FROM =B40_DATA_SET
                WHERE B40_SET_DATASET = 1
                BROWSE ACCESS;

                printf("\n\n");
                sprintf(cCadenaAux, "lNumReg: [%ld], sqlcode: [%d]", lNumReg, sqlcode);
                strcpy(cCadenaSalida, "Si esta el campo FML STDS_OPE_SOEID, consulta SQL: ");
                strcat(cCadenaSalida, cCadenaAux);
                Fadd32 (pBuffer m STDS_OPE_SOEID , cCadenaSalida, 0);
                sPresente = 1;
            }
        if (sPresente)
            tpreturn(TPSUCCESS, 0, (char *)pBuffer, 0,0);
        else
            tpreturn(TPFAIL, 0, (char *)pBuffer, 0, 0);
    }