/****************************************************************************/
/* Identificacion       : srvNew5Seg.h                                      */
/* Autor                : Alfonso Rafael Tlapanco Vaca (ARTV)               */
/****************************************************************************/

/****************************************************************************/
/*  Librerias Generales                                                     */
/****************************************************************************/
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <ctype.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/utsname.h>
#include <sql.h>



/****************************************************************************/
/*  Librerias Tuxedo                                                        */
/****************************************************************************/
#include "atmi.h"
#include "fm132.h"
#include "estandar.flds.h"
#include "aplicativos.flds.h"
#include "Catalogo_101.flds.h"
#include "clientes.flds.h"

#include <cextdecs.h( SQLCAFSCODE           \
                     ,SQLCATOBUFFER         \
                     ,CONVERTTIMESTAMP      \
                     ,JULIANTIMESTAM        \
                     ,INTERPRETTIMESTAMP)>



/****************************************************************************/
/*  DEFINES                                                                 */
/****************************************************************************/




/****************************************************************************/
/*  Prototipos de Funciones                                                 */
/****************************************************************************/

int tpsvrinit(int argc, char *argv[]);
void tpsvrdone(void);
void OPI_TuxCall(TPSVCINFO *rqst);


