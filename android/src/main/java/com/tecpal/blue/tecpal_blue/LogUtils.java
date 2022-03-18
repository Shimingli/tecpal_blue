package com.tecpal.blue.tecpal_blue;
import android.os.AsyncTask;
import android.text.TextUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author: Sinya
 * @Editor：
 * @Date: 2015-5-20 11:24:31
 * @Description:
 */
public class LogUtils {

    private static boolean DEBUG = true;

    private static final int TYPE_D = 0;
    private static final int TYPE_I = 1;
    private static final int TYPE_E = 2;
    private static final int TYPE_W = 3;

    private static final int SINGLE_LENGTH = 3000;

    public static void init(boolean debug) {
        DEBUG = debug;
    }

    public static boolean isPrint() {
        return DEBUG;
    }

    public static void setDebug(boolean isOpen) {
        DEBUG = isOpen;
    }

    public static void Dewen(String string, Object... object) {
        if (DEBUG) {
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
                    ? object[0].toString()//
                    : "");

            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("Dewen", TYPE_I, content, SINGLE_LENGTH);
            }
        }
    }

    public static void Sinya(String string, Object... object) {
        if (DEBUG) {
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
                    ? " " + object[0].toString()//
                    : "");

            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("Sinya", TYPE_I, content, SINGLE_LENGTH);
            }
        }
    }


    public static void Stan(String string, Object... object) {
        if (DEBUG) {
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
                    ? object[0].toString()//
                    : "");

            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("Stan", TYPE_I, content, SINGLE_LENGTH);
            }
        }
    }

    public static void Jennifer(String string, Object... object) {
        if (DEBUG) {
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
                    ? object[0].toString()//
                    : "");

            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("Jennifer", TYPE_I, content, SINGLE_LENGTH);
            }
        }
    }

    public static void Sming(String string, Object... object) {
        if (DEBUG) {
            String curThreadName = Thread.currentThread().getName();
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = " ** " + curThreadName + " ** " + stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
                    ? object[0].toString() : "");
            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("Sming", TYPE_I, content, SINGLE_LENGTH);
            }
        }
    }

    public static void SmingE(String string, Object... object) {
        if (DEBUG) {
            String curThreadName = Thread.currentThread().getName();
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = " ** " + curThreadName + " ** " + stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
                    ? object[0].toString() : "");
            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("Sming ERROR_LOG   ", TYPE_I, content, SINGLE_LENGTH);
            }
        }
    }


    public static void SmingW(String string) {
        if (DEBUG) {
            String curThreadName = Thread.currentThread().getName();
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = curThreadName + " # " + stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            // String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
            //      ? object[0].toString()
            //      : "");
            String content = curThreadName + "\n" + string;
            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("Sming", TYPE_I, "WARM_LOG\n" + content, SINGLE_LENGTH);
            }
        }
    }

    public static void print(String string, Object... object) {
        if (DEBUG) {
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
                    ? object[0].toString()//
                    : "");

            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("TGI", TYPE_I, content, SINGLE_LENGTH);
            }
        }
    }

    public static void printI(String tag, String string, Object... object) {
        if (DEBUG) {
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
                    ? object[0].toString()//
                    : "");

            if (!TextUtils.isEmpty(content)) {
                showLogCompletion(tag, TYPE_I, content, SINGLE_LENGTH);
            }
        }
    }

    public static void printE(String string, Object... object) {
        if (DEBUG) {
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string + ((object != null && object.length >= 1 && object[0] != null)//
                    ? " " + object[0].toString()//
                    : "");

            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("Exception", TYPE_E, content, SINGLE_LENGTH);
            }
        }
    }

    public static void printE(String string) {
        if (DEBUG) {
            StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
            String head = stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
            String content = head + string;

            if (!TextUtils.isEmpty(content)) {
                showLogCompletion("TGI", TYPE_E, content, SINGLE_LENGTH);
            }
        }
    }

    public static String getLogAddress() {
        StackTraceElement stackTrace = new Throwable().getStackTrace()[1];
        String head = stackTrace.getClassName() + "." + stackTrace.getMethodName() + "()" + "; " + stackTrace.getLineNumber() + " - Lines:\n";
        return head;
    }

    private static void showLogCompletion(String tag, int type, String content, int showCount) {

        long length = content.length();

        if (length <= showCount) {
            printLog(tag, type, content);

        } else {
            new PrintTask(tag, type, content).execute();
        }
    }

    static class PrintTask extends AsyncTask<String, Void, String> {
        private String content;
        private String tag;
        private int type;
        private int length;
        private List<String> list;

        public PrintTask(String tag, int type, String content) {
            this.content = content;
            this.tag = tag;
            this.type = type;
            this.length = content.length();
            list = new ArrayList<>();
        }

        @Override
        protected void onPreExecute() {
        }

        @Override
        protected String doInBackground(String... params) {
            if (length % SINGLE_LENGTH != 0) {
                for (int i = 0; i < length / SINGLE_LENGTH; i++) {
                    String newContent = content.substring(i * SINGLE_LENGTH, (i + 1) * SINGLE_LENGTH);
                    list.add(newContent);
                }
                list.add(content.substring(length / SINGLE_LENGTH * SINGLE_LENGTH, length % SINGLE_LENGTH + length / SINGLE_LENGTH * SINGLE_LENGTH));
            } else {
                for (int j = 0; j < length / SINGLE_LENGTH; j++) {
                    String newContent = content.substring(j * SINGLE_LENGTH, (j + 1) * SINGLE_LENGTH);
                    list.add(newContent);
                }
            }

            return tag;
        }

        @Override
        protected void onPostExecute(String s) {
            for (int i = 0; i < list.size(); i++) {
                printLog(tag, type, list.get(i));
            }
        }
    }

    private static void printLog(String tag, int type, String content) {
        switch (type) {
            case TYPE_D:
                android.util.Log.d(tag, content);
                break;
            case TYPE_I:
                android.util.Log.i(tag, content);
                break;
            case TYPE_E:
                android.util.Log.e(tag, content);
                break;
            case TYPE_W:
                android.util.Log.w(tag, content);
                break;
            default:
                break;
        }

    }
}