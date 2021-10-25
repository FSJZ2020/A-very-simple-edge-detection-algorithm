a=imread('QQ图片20210804042119.jpg');%读入文件名称
t=15;%检测阈值，当一个像素与其他像素差多大时检测出来
s=size(a);
b=zeros(s(1)-1,s(2)-1,3);
d=zeros(s(1)-1,s(2)-1,3);
b1=zeros(s(1)-1,s(2)-1,2);
for i=1:s(1)-1
    for j=1:s(2)-1
        for k=1:3
            b(i,j,k)=a(i,j,k)-a(i+1,j,k);%横向比较
            d(i,j,k)=a(i,j,k)-a(i,j+1,k);%纵向比较
        end
    end
end
for i=1:s(1)-1
    for j=1:s(2)-1
        b1(i,j,1)=b(i,j,1)+b(i,j,2)+b(i,j,3);%RGB差值求和
        b1(i,j,2)=d(i,j,1)+d(i,j,2)+d(i,j,3);
    end
end
c=zeros(s(1)-1,s(2)-1);
for i=1:s(1)-1
    for j=1:s(2)-1
        if b1(i,j,1)>t || b1(i,j,2)>t
            c(i,j)=255;
        else 
            c(i,j)=0;
        end
    end
end
%% 去除噪点，将周围小于5的亮位变暗，两轮
e=decrease(c,5,3);
%% 图像增强，将周围大于6的空位点亮，两轮
e=increase(e,6,2);
%% 
imshow(e)
%% 降噪函数
function result=decrease(data,value,times)
result=data;
s=size(data);
    for t=1:times
        for i=2:s(1)-1
            for j=2:s(2)-1
                if data(i,j)==255
                    if data(i-1,j-1)+data(i,j-1)+data(i+1,j-1)+data(i-1,j)+data(i+1,j)+data(i-1,j+1)+data(i,j+1)+data(i+1,j+1)<255*value
                        result(i,j)=0;
                    end
                end
            end
        end
        data=result;
    end
end
%% 图像增强函数
function result=increase(data,value,times)
result=data;
s=size(data);
    for t=1:times
        for i=2:s(1)-1
            for j=2:s(2)-1
                if data(i,j)==0
                    if data(i-1,j-1)+data(i,j-1)+data(i+1,j-1)+data(i-1,j)+data(i+1,j)+data(i-1,j+1)+data(i,j+1)+data(i+1,j+1)>255*value
                        result(i,j)=255;
                    end
                end
            end
        end
        data=result;
    end
end