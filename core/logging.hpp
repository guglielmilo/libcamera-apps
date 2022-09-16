#pragma once

#include <cstdio>
#include <functional>
#include <iostream>
#include <sstream>
#include <string>

#include "core/libcamera_app.hpp"

struct Logging
{
	static inline void logSetCallback(std::function<void(unsigned, const std::string&)> callback)
	{
		callback_ = callback;
	}

	static inline void log(unsigned level, std::string&& text)
	{
		if (callback_)
		{
			callback_(level, text);
		}
		else
		{
			std::cerr << text << std::endl;
		}
	}

private:
	inline static std::function<void(unsigned, const std::string&)> callback_ = nullptr;
};


#define LOG(level, text) 								\
		do										 		\
		{												\
			if (LibcameraApp::GetVerbosity() >= level)	\
			{											\
				std::ostringstream ss;					\
				ss << (text);							\
				Logging::log(level, ss.str()); 			\
			}											\
		}										 		\
		while(0)


#define LOG_ERROR(text) 	 					 \
		do										 \
		{										 \
			std::ostringstream ss;				 \
			ss << (text);						 \
			Logging::log(unsigned(0), ss.str()); \
		}										 \
		while(0)
