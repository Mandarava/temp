package utils.kettle;

import java.io.File;
import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.core.exception.KettleException;
import org.pentaho.di.job.Job;
import org.pentaho.di.job.JobMeta;
import org.pentaho.di.repository.Repository;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;
import exception.BusinessException;


/**
 * 执行Kettle工具类
 * 
 */
public class KettleUtil {

    private static final String FILEPATH =
            "code\\trunk\\src\\main\\java\\com\\winning\\kettle";


    /**
     * 批量执行kettle文件
     * 
     * @throws KettleException
     */
    public static void runKettle() throws KettleException {

        String path = new File("").getAbsolutePath() + "\\WebRoot\\kjb";
        File[] files = new File(path).listFiles();
        for (File file : files) {
            if (file.getPath().endsWith(".ktr")) {
                KettleUtil.executeTrasformation(file.getPath());
            }
            else if (file.getPath().endsWith(".kjb")) {
                KettleUtil.executeJob(file.getPath());
            }

        }
    }


    /**
     * 批量执行kettle文件
     * 
     * @param rootPath kettle文件目录
     * @throws KettleException
     */
    public static void runKettle(String rootPath) throws KettleException {
        File[] files = new File(rootPath).listFiles();
        for (File file : files) {
            if (file.getPath().endsWith(".ktr")) {
                KettleUtil.executeTrasformation(file.getPath());
            }
            else if (file.getPath().endsWith(".kjb")) {
                KettleUtil.executeJob(file.getPath());
            }

        }
    }


    /**
     * 执行kettle转换
     * 
     * @param ktrPath 转换文件的路径，后缀ktr
     * @throws KettleException
     */
    public static void executeTrasformation(String ktrPath)
        throws KettleException {

        try {

            KettleEnvironment.init();

            TransMeta metadata = new TransMeta(ktrPath);
            Trans trans = new Trans(metadata);

            /* 设置日志等级(debug非常详细，对于跟踪问题有帮助) */
            // trans.setLogLevel(LogLevel.ROWLEVEL);

            /* Setting the Parameter Values */
            // trans.setParameterValue("PARAM_ID", "1");

            trans.execute(null);

            trans.waitUntilFinished();

            if (trans.getErrors() > 0) {
                throw new BusinessException("Error Executing Transformation");
            }

        }
        catch (KettleException ex) {
            throw ex;
        }

    }


    /**
     * 执行kettle作业
     * 
     * @param kjbPath 作业文件的路径，后缀kjb
     * @throws KettleException
     */
    public static void executeJob(String kjbPath) throws KettleException {

        /**
         * Unlike the ktr java code, for executing a kjb, you will need to
         * define a repository path too. Since i haven’t used any repository, it
         * is null for me. But in case you are using a repo, you might need to
         * define it.
         */
        Repository repository = null;

        try {
            KettleEnvironment.init();

            JobMeta jobmeta = new JobMeta(kjbPath, repository);
            Job job = new Job(repository, jobmeta);

            /* 向Job 脚本传递参数，脚本中获取参数值：${参数名} */
            // job.setVariable(paraname, paravalue);

            job.start();
            job.waitUntilFinished();

            if (job.getErrors() > 0) {
                throw new BusinessException("Error Executing Job");
            }

        }
        catch (KettleException ex) {
            throw ex;
        }
    }
}
