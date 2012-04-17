
#include <Ice/Ice.h>
#include "Sample/Hello.h"

int main(int argc, char* argv[]) {
  Ice::CommunicatorPtr ic = Ice::initialize();
  Example::HelloPrx::checkedCast(ic->stringToProxy("na"));
  
  return 0;
}

