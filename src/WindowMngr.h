#ifndef __WINDOWMNGR_H__
#define __WINDOWMNGR_H__

#include "stdafx.h"

class WindowManager {
public:
	static HWND ActiveWindow();
	static HWND CurrentWindow();
	static std::wstring GetWindowList(tVariant* paParams, const long lSizeArray);
	static std::wstring GetWindowInfo(tVariant* paParams, const long lSizeArray);
	static std::wstring GetWindowSize(tVariant* paParams, const long lSizeArray);
	static BOOL SetWindowState(tVariant* paParams, const long lSizeArray);
	static BOOL SetWindowSize(tVariant* paParams, const long lSizeArray);
	static BOOL SetWindowPos(tVariant* paParams, const long lSizeArray);
	static BOOL EnableResizing(tVariant* paParams, const long lSizeArray);
	static BOOL Restore(tVariant* paParams, const long lSizeArray);
	static BOOL Maximize(tVariant* paParams, const long lSizeArray);
	static BOOL Minimize(tVariant* paParams, const long lSizeArray);
	static BOOL Activate(tVariant* paParams, const long lSizeArray);
private:
	static BOOL WindowManager::SetWindowState(HWND hWnd, int iMode, bool bActivate);
	int32_t WindowManager::GetWindowState(tVariant* paParams, const long lSizeArray);
	static bool IsMaximized(HWND hWnd);
};

#endif //__WINDOWMNGR_H__