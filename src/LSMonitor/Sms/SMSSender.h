#pragma once

#define MAX_PARAMS 11

#ifdef USE_MSSOAP
#import "msxml4.dll"
#import "mssoap30.dll" exclude("IErrorInfo", "IStream", "ISequentialStream", "_LARGE_INTEGER", "_ULARGE_INTEGER","tagSTATSTG", "_FILETIME")
using namespace MSSOAPLib30;
#else
// Stub: MSSOAP not installed
#endif

class CSMSSender
{
protected:
	enum PARAMTYPE
	{
		USER_DATA3 = 0,
		USER_DATA2 = 1,
		USER_DATA1 = 2,
		RESERVED_DATE = 3,
		MERGE_NAME = 4,
		SMS_CONTENTS = 5,
		RECIEVE_NUMBER = 6,
		SEND_NUMBER = 7,
		DNS_NAME = 8,
		PASSWORD = 9,
		ID = 10
	};
protected:
#ifdef USE_MSSOAP
	ISoapClientPtr m_pSoapClient;
#endif

protected:
	bool ChangeType( VARIANTARG  &params, const CString &ParamText );

public:
	bool Init();
	bool SendSMS(const CString &szID, const CString &szPassWord,const CString &szDNSName,const CString &szSendNumber
		,const CString &szRecieveNumber,const CString &szContents);

public:
	CSMSSender(void);
	~CSMSSender(void);

};
